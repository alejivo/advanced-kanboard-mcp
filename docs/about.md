---
title: About
nav_order: 2
description: An MCP that connects autonomous agents to specific Kanboard boards, with granular access. Another plugin will interact with this one.
---

# About

Advanced Kanboard MCP is an MCP server for Kanboard. It connects autonomous agents, such as Cursor and Claude, to the boards they are allowed to use.

Access is granular. Each person has their own token, and that token only reaches the boards and tools their role allows. An agent using that token can work on those kanban boards and nothing else.

This plugin is the access layer. Another plugin will interact with it.

## How access is limited

- A token for each user, limited to the boards that user can already see.
- Role checks on every call, using Kanboard's viewer, member, manager, and application roles.
- An [endpoint gateway]({% link gateway.md %}) so each person turns tools on or off for their own token.
- Header authentication, an admin switch to reject tokens in the query string, and narrower comment payloads.

The [changelog]({% link changelog.md %}) records how those controls arrived. The [videos]({% link videos.md %}) show the integrations page, a second user's token, and the gateway.

## Install name

Releases install as the Kanboard plugin `ModelContextProtocol`. Each archive is named `ModelContextProtocol-<version>.zip`.

This line started as a fork of the [original Kanboard MCP](https://github.com/ChristianJStarr/kanboard-mcp) by Christian Starr. A release here is not a drop-in replacement for a release of that plugin.

## Contributing

New tools, tighter authorization, and bug fixes fit this repository. Open a pull request against [advanced-kanboard-mcp](https://github.com/alejivo/advanced-kanboard-mcp).

Questions about the original plugin belong on [ChristianJStarr/kanboard-mcp](https://github.com/ChristianJStarr/kanboard-mcp).
