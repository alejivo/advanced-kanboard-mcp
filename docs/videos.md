---
title: Videos
nav_order: 10
description: Recordings of the integrations page, per-user tokens, and the endpoint gateway.
---

# Videos

These are the walkthroughs recorded against a local Kanboard. They sign in as `admin` / `admin` unless a later step creates another user.

## Integrations page

Generate a token, copy the header and URL client blocks, turn URL tokens off and back on, and set a 180-day token lifetime under **Instance settings**. Leaving the page and coming back keeps that lifetime.

<video class="docs-video" controls playsinline preload="metadata">
  <source src="{{ '/assets/videos/interface.webm' | relative_url }}" type="video/webm">
</video>

## Per-user tokens

An administrator generates a token, saves **Disable token in URL**, then creates another user. That user generates a different token. The administrator's token is unchanged.

<video class="docs-video" controls playsinline preload="metadata">
  <source src="{{ '/assets/videos/tokens.webm' | relative_url }}" type="video/webm">
</video>

## Endpoint gateway

An administrator generates a token and saves which endpoints are on. A project viewer then opens their own integrations page and only sees the endpoints that role allows.

<video class="docs-video" controls playsinline preload="metadata">
  <source src="{{ '/assets/videos/gateway.webm' | relative_url }}" type="video/webm">
</video>
