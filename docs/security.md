---
title: Security
nav_order: 6
description: Per-user tokens, role checks, and how the token should be sent.
---

# Security

Authentication identifies the user. The [endpoint gateway]({% link gateway.md %}) then decides which of that user's allowed endpoints are on. This page covers the token and the role checks that apply even when an endpoint is enabled.

## Per-user tokens

- Each Kanboard user has one active MCP token. It identifies that user on every request.
- Tokens are 64 hex characters (256 bits), generated with `random_bytes`.
- Only the SHA-256 hash is stored. The plaintext is shown once, after generation.
- Clicking **Autogenerar** invalidates the old token and issues a new one.
- When a user account is deactivated in Kanboard, their token stops working immediately.

## What each role can do

Every tool call is checked against the token user's Kanboard permissions.

| Role | What the token grants |
| --- | --- |
| Project viewer | Read-only: `get_projects`, `get_tasks`, `get_task_details`, `get_columns`, `get_categories`, `get_swimlanes`, `get_task_comments`, `get_users`, and the two read resources. |
| Project member | Viewer rights, plus task create, update, move, comment, assign, and due date. Delete only tasks they created. |
| Custom project role | The same task access as a member, minus that role's Kanboard restrictions. |
| Project manager | Member rights, plus delete any task, and full column, category, and swimlane changes. |
| App manager | Can `create_project`. Project access follows normal membership. Board tools stay unavailable unless they are also a project manager or an app admin. |
| App admin | Project manager on every active project. Also `create_project` and `get_users` across all users. |

A role can call a tool only when the gateway has that endpoint enabled. See [what each role is offered]({% link gateway.md %}#what-each-role-is-offered).

Object ids from another user's projects return a generic `Forbidden` error, so a caller cannot probe for ids they cannot see.

## Data the API returns

- `get_projects` and `kanboard://projects` return only the boards the token user can see. The project public-access token is omitted.
- `get_users` and `kanboard://users` return only `id`, `username`, and `name`.
- `get_task_comments` returns comment id, task id, user id, username, name, body, dates, and visibility. It does not return email or avatar path.

## How the token is sent

Preferred: `Authorization: Bearer YOUR_TOKEN`. The plugin also reads `REDIRECT_HTTP_AUTHORIZATION` when PHP-CGI or a rewrite does not populate `HTTP_AUTHORIZATION`.

Compatibility: the `token` query-string parameter, unless an administrator has disabled URL tokens.

- If URL tokens are allowed and the header and query string both carry a token and those tokens differ, the request is rejected.
- If URL tokens are disabled, `$_GET['token']` is ignored. A valid bearer header still authenticates.

`Referrer-Policy: no-referrer` is sent on every MCP response so the token is not forwarded to a third-party origin via `Referer`. That does not stop your own web server or proxy from logging a `?token=` URL.

{: .warning }
Prefer the bearer header. A token in the query string can end up in access logs.
