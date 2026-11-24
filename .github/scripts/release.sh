#!/usr/bin/env bash
# Publish a GitHub release from master.
# Runs in GitHub Actions. DRY_RUN=1 prints the decision and stops.
set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

read_version() {
  sed -n "/function getPluginVersion/,/^    }/s/.*return '\\([^']*\\)'.*/\\1/p" Plugin.php
}

latest_release_tag() {
  git tag -l | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1 || true
}

# Exit 0 when $1 > $2. Both arguments are MAJOR.MINOR.PATCH.
version_gt() {
  [[ "$1" != "$2" && "$(printf '%s\n%s\n' "$1" "$2" | sort -V | tail -n 1)" == "$1" ]]
}

bump_patch() {
  local major minor patch
  IFS=. read -r major minor patch <<<"$1"
  echo "${major}.${minor}.$((patch + 1))"
}

write_version() {
  local old="$1"
  local new="$2"
  python3 - "$old" "$new" <<'PY'
import pathlib, re, sys
old, new = sys.argv[1], sys.argv[2]
path = pathlib.Path("Plugin.php")
text = path.read_text()
pattern = re.compile(
    r"(function getPluginVersion\(\)\s*\{\s*return ')" + re.escape(old) + r"(';\s*\})",
)
updated, count = pattern.subn(r"\g<1>" + new + r"\2", text, count=1)
if count != 1:
    raise SystemExit(f"expected to replace getPluginVersion {old} once, matched {count}")
path.write_text(updated)
PY
}

# Highest stable tag strictly older than MAJOR.MINOR.PATCH $1.
previous_for() {
  local version="$1"
  local tag ver candidate=""
  while read -r tag; do
    [[ -z "$tag" ]] && continue
    ver="${tag#v}"
    if version_gt "$version" "$ver"; then
      candidate="$tag"
    fi
  done < <(git tag -l | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | sort -V || true)
  printf '%s' "$candidate"
}

release_notes() {
  local version="$1"
  local previous="$2"
  local range="HEAD"
  local compare_url="https://github.com/${GITHUB_REPOSITORY}/commits/v${version}"
  if [[ -n "$previous" ]]; then
    range="${previous}..HEAD"
    compare_url="https://github.com/${GITHUB_REPOSITORY}/compare/${previous}...v${version}"
  fi
  local notes
  notes="$(
    git log "$range" --first-parent --invert-grep --grep='\[release\]' --pretty=format:'%s%x1f%b%x1e' \
      | python3 -c '
import sys
items = []
for record in sys.stdin.read().split("\x1e"):
    if not record.strip():
        continue
    subject, _, body = record.partition("\x1f")
    subject = subject.strip()
    body_lines = []
    for line in body.splitlines():
        stripped = line.strip()
        if not stripped or stripped.startswith(("Co-authored-by:", "Signed-off-by:")):
            continue
        body_lines.append(stripped)
    if subject.startswith("Merge ") and body_lines:
        items.append(body_lines[0])
    elif subject:
        items.append(subject)
print("\n".join(f"* {item}" for item in items))
'
  )"
  if [[ -z "$notes" ]]; then
    notes="* Release ${version}."
  fi
  cat <<EOF
Install by extracting \`ModelContextProtocol/\` from \`ModelContextProtocol-${version}.zip\` into the Kanboard \`plugins/\` directory.

${notes}

**Full Changelog**: ${compare_url}
EOF
}

publish_release() {
  local version="$1"
  local previous
  previous="$(previous_for "$version")"
  local tag="v${version}"
  local zip="ModelContextProtocol-${version}.zip"

  make package
  if ! unzip -p "$zip" ModelContextProtocol/Plugin.php | grep -q "return '${version}';"; then
    echo "Zip ${zip} does not contain Plugin.php ${version}" >&2
    exit 1
  fi

  if git rev-parse -q --verify "refs/tags/${tag}" >/dev/null; then
    local tag_commit head_commit
    tag_commit="$(git rev-list -n 1 "$tag")"
    head_commit="$(git rev-parse HEAD)"
    if [[ "$tag_commit" != "$head_commit" ]]; then
      echo "Tag ${tag} already points at ${tag_commit}, not ${head_commit}" >&2
      exit 1
    fi
  else
    git -c tag.gpgsign=false tag "$tag"
    git push origin "refs/tags/${tag}"
  fi

  if gh release view "$tag" >/dev/null 2>&1; then
    echo "GitHub release ${tag} already exists"
    return 0
  fi

  local notes_file
  notes_file="$(mktemp)"
  release_notes "$version" "$previous" >"$notes_file"
  gh release create "$tag" "$zip" --title "$tag" --notes-file "$notes_file" --verify-tag
}

main() {
  if [[ "${GITHUB_ACTIONS:-}" != "true" && "${DRY_RUN:-}" != "1" ]]; then
    echo "Refusing to publish outside GitHub Actions. Set DRY_RUN=1 to preview." >&2
    exit 1
  fi

  git fetch origin master --tags --force
  if [[ "${DRY_RUN:-}" != "1" ]]; then
    git checkout -B master origin/master
  fi

  local version latest latest_version target
  version="$(read_version)"
  if [[ ! "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Plugin.php version must be MAJOR.MINOR.PATCH, found: ${version}" >&2
    exit 1
  fi

  latest="$(latest_release_tag)"
  latest_version="${latest#v}"

  local head_subject
  head_subject="$(git log -1 --pretty=%s)"
  if [[ "$head_subject" =~ ^chore:\ release\ .+\ \[release\]$ ]]; then
    if [[ "${DRY_RUN:-}" == "1" ]]; then
      echo "HEAD is already release ${version}; would publish only if the GitHub release is missing"
      exit 0
    fi
    publish_release "$version"
    exit 0
  fi

  if [[ -z "$latest_version" || "$version" == "$latest_version" ]]; then
    if [[ -n "$latest_version" ]]; then
      target="$(bump_patch "$version")"
    else
      target="$version"
    fi
  elif version_gt "$version" "$latest_version"; then
    target="$version"
  else
    echo "Plugin.php ${version} is behind latest tag ${latest}" >&2
    exit 1
  fi

  echo "Latest tag: ${latest:-none}"
  echo "Plugin.php: ${version}"
  echo "Release:    ${target}"

  if [[ "${DRY_RUN:-}" == "1" ]]; then
    echo "DRY_RUN: not committing, tagging, or publishing"
    exit 0
  fi

  if [[ "$target" != "$version" ]]; then
    write_version "$version" "$target"
    git -c user.name='github-actions[bot]' \
      -c user.email='41898282+github-actions[bot]@users.noreply.github.com' \
      add Plugin.php
    git -c user.name='github-actions[bot]' \
      -c user.email='41898282+github-actions[bot]@users.noreply.github.com' \
      -c commit.gpgsign=false \
      commit -m "chore: release ${target} [release]"
    if ! git push origin HEAD:master; then
      echo "Could not push the release commit to master. GitHub Actions needs permission to push to that branch." >&2
      exit 1
    fi
  fi

  publish_release "$target"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi
