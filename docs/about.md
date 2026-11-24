---
title: About
nav_order: 2
description: Advanced Kanboard MCP is a fork of the original plugin, meant to iterate quickly with new features that may broken the original MCP.
---

# About

Advanced Kanboard MCP is a fork of the [original Kanboard MCP](https://github.com/ChristianJStarr/kanboard-mcp) by Christian Starr. This fork exists to iterate quickly and experiment with new features.

The original plugin is the base: a Kanboard extension that lets an MCP client manage projects and tasks. This repository, [advanced-kanboard-mcp](https://github.com/alejivo/advanced-kanboard-mcp), is where fast iterations lands. This plugin its stable too but not 100% compatible with the original.

Releases from this fork still install as the Kanboard plugin `ModelContextProtocol`. Each archive is named `ModelContextProtocol-<version>.zip`.

If you want the project maintained by its original author, use [ChristianJStarr/kanboard-mcp](https://github.com/ChristianJStarr/kanboard-mcp).

## What this fork is experimenting with

Work on this fork has focused on tighter, per-person access:

- A token for each user, limited to the boards that user can already see.
- Role checks on every call, using Kanboard's viewer, member, manager, and application roles.
- An [endpoint gateway]({% link gateway.md %}) so each person turns tools on or off for their own token.
- Header authentication, an admin switch to reject tokens in the query string, and narrower comment payloads.

The [changelog]({% link changelog.md %}) records how those experiments arrived.

## Contributing

Changes that try a new tool, tighten authorization, or fix a bug fit this repository. Open a pull request against [advanced-kanboard-mcp](https://github.com/alejivo/advanced-kanboard-mcp).

Questions about the upstream plugin belong on the [original repository](https://github.com/ChristianJStarr/kanboard-mcp).
