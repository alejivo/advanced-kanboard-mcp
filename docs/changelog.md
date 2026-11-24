---
title: Changelog
nav_order: 9
description: Changes in each Advanced Kanboard MCP release.
---

# Changelog

## v1.2.3

- **URL tokens and comment PII.** The gateway branch includes the 1.1.4 Integrations header config, the admin disable-URL-token setting, CGI Authorization, and comment privacy fixes.

## v1.2.2

- **Review fixes.** The gateway branch includes the 1.1.3 authorization fixes. Schema version 4 removes any leftover `token_plain` value and then creates the endpoint grants.

## v1.2.1

- **Integrations submit.** Generate Token and Save access post forms rendered outside Kanboard's settings form, so one creates a token and the other saves grants. Both redirects return to the core integrations page and do not name this plugin.

## v1.2.0

- **Endpoint gateway.** Each user can enable or disable the MCP endpoints their role allows. Old tokens keep writes on via the migration backfill. New tokens start with writes off.
- **Unknown versus forbidden.** A role-hidden or unknown tool returns `Unknown tool`. A role-allowed endpoint that is off returns `Forbidden` and is not dispatched.
- **List refresh.** `listChanged` stays false. Clients should reconnect so `tools/list` matches the toggles. `tools/call` enforces the switch without waiting for that refresh.

## v1.1.4

- **Header configuration.** Integrations shows the spec-compliant MCP client block (URL without a token, plus `Authorization: Bearer`) and a compatibility URL-with-token block, with a warning that query-string tokens can appear in access logs.
- **Disable URL tokens.** Administrators can reject `?token=` from Settings → Integrations. Header authentication is unchanged. The setting survives token rotation.
- **CGI Authorization.** Bearer tokens are read from `HTTP_AUTHORIZATION`, then `REDIRECT_HTTP_AUTHORIZATION`.
- **Comment privacy.** `get_task_comments` no longer returns email or avatar path.

## v1.1.3

- **Comment visibility.** `get_task_comments` follows Kanboard's application-role visibility rules for the token user.
- **Project creation.** `create_project` adds the token user as the project owner and manager.
- **Token storage.** Only the SHA-256 hash is stored. The plaintext is shown once after generation.
- **Custom roles.** A custom project role can change tasks, except where that role has a Kanboard restriction.
- **Project payload.** Project listings no longer include the public-access token.
- **MySQL upgrade.** Replacing `mcp_tokens` can be run again if the table was already dropped.

## v1.1.2

- **Integrations submit.** Generate Token posts a form rendered outside Kanboard's settings form, so the button creates a token instead of saving settings. The redirect returns to the core integrations page and does not name this plugin.

## v1.1.1

- **Integrations form CSRF.** Token rotation accepts the reusable form token and reads the posted redirect target from the body, so the Autogenerar form works.
- **Admin user listing.** `get_users` queries active users for `id`, `username`, and `name`. The previous lookup does not exist on Kanboard 1.2.45.

## v1.1.0

- **Per-user tokens.** Each user has their own MCP token, scoped to their boards and role.
- **Autogenerar button.** Token rotation is available to every user from Settings → Integrations or their profile.
- **Role enforcement.** All 26 tools and both resources enforce Kanboard project roles on every call.
- **User data privacy.** `get_users` no longer exposes password hashes, API tokens, or two-factor state.
- **Token transport.** `Authorization: Bearer` support, `Referrer-Policy: no-referrer`, and rejection of conflicting dual-token requests.

## v1.0.0

Initial release of the original plugin surface this fork builds on.

- 26 tools covering Kanboard projects, tasks, columns, categories, and swimlanes.
- AI assistant setup for Cursor and Claude.
