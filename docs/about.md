---
title: About
nav_order: 2
description: A stable fork of the original Kanboard MCP. New features break compatibility with that plugin so this one can move freely and integrate with another plugin.
---

# About

Advanced Kanboard MCP is a fork of the [original Kanboard MCP](https://github.com/ChristianJStarr/kanboard-mcp) by Christian Starr.

This plugin is meant to stay stable for the people who use it. New features keep landing here, and those features break compatibility with the original MCP. The project was forked so development can move freely, and so this plugin can be integrated with another plugin, without staying compatible with the original.

The original plugin remains the one maintained by its author. Use [ChristianJStarr/kanboard-mcp](https://github.com/ChristianJStarr/kanboard-mcp) when you need that plugin. Use this repository when you need the line that has already diverged from it.

Releases from this fork still install as the Kanboard plugin `ModelContextProtocol`. Each archive is named `ModelContextProtocol-<version>.zip`. A release of this fork is not a drop-in replacement for a release of the original plugin.

## Where this fork has diverged

- A token for each user, limited to the boards that user can already see.
- Role checks on every call, using Kanboard's viewer, member, manager, and application roles.
- An [endpoint gateway]({% link gateway.md %}) so each person turns tools on or off for their own token.
- Header authentication, an admin switch to reject tokens in the query string, and narrower comment payloads.

The [changelog]({% link changelog.md %}) records how those changes arrived.

## Contributing

New tools, tighter authorization, and bug fixes fit this repository. Open a pull request against [advanced-kanboard-mcp](https://github.com/alejivo/advanced-kanboard-mcp).

Questions about the original plugin belong on [ChristianJStarr/kanboard-mcp](https://github.com/ChristianJStarr/kanboard-mcp).
