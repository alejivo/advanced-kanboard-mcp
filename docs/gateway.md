---
title: Endpoint gateway
nav_order: 7
description: Each user turns on the MCP endpoints their role allows.
---

# Endpoint gateway

Authentication identifies the user. The gateway chooses which role-allowed endpoints are on for that user's own token.

The integrations page has a second form, separate from **Autogenerar** and from Kanboard's own settings form. It lists only the endpoints the signed-in user is allowed to use. Saving stores `enabled=1` or `enabled=0` for each of those endpoints. Rows are never deleted, and regenerating a token does not remove them.

{: .note }
An administrator viewing another profile does not see or edit that person's gateway. The form is always the session user, the same as the token panel.

## Defaults for old and new tokens

- Tokens that already existed when the instance was upgraded keep their write endpoints on. The schema backfill inserts `enabled=1` for every write-class catalog endpoint for each existing `mcp_tokens` user. Read endpoints stay on without inserted rows.
- Tokens created after the upgrade start with reads on and writes off until that user saves the form. A missing grant row means the catalog default.

A fresh app-admin token shows the read endpoints until writes are turned on. An admin whose token existed before the upgrade still sees writes, because the backfill left them enabled.

## What each role is offered

The gateway lists an endpoint only when the role may use it and the user has enabled it.

| Role | Listed when enabled |
| --- | --- |
| Project viewer | The 8 read tools and the two read resources |
| Project member | Viewer endpoints, plus task create, update, move, assign, due date, comment, and delete |
| Project manager | Member endpoints, plus board tools (columns, categories, swimlanes) |
| App manager | The 8 read tools, the two read resources, and `create_project`. Board tools stay hidden unless they are also a project manager or an app admin. A project manager who is not an app manager does not get `create_project`. |
| App admin | All 26 tools and both resources on their own token, once those endpoints are enabled |

## How clients see a change

`initialize` keeps `listChanged` false for tools and resources, so clients should reconnect to refresh `tools/list` after a save. `tools/call` still enforces the toggle immediately.

## Errors

- A role-allowed endpoint that is switched off is omitted from the list. Calling it returns a tool result whose text is exactly `Forbidden`, including when the arguments are invalid.
- A name the role cannot use, and any unknown name, both return JSON-RPC `-32602` with message `Unknown tool: {name}`.
- A disabled resource reads as `-32002` Resource not found with `data.uri`, the same as an unknown URI.
- Turning a hidden tool on in the database does not make it callable.
