---
title: Home
nav_order: 1
description: Kanboard plugin that lets MCP clients manage the boards a user can already see.
---

# Advanced Kanboard MCP

Advanced Kanboard MCP is a Kanboard plugin. It speaks the [Model Context Protocol](https://modelcontextprotocol.io/) so clients such as Cursor and Claude can work with the projects, tasks, and boards that the signed-in user is allowed to see.

It is a fork of the original Kanboard MCP. The plugin stays stable for its users, and new features break compatibility with the original MCP so this project can move freely and integrate with another plugin. The [About]({% link about.md %}) page explains that.

## Start here

1. [Install the plugin]({% link installation.md %}) and generate a token for your own user.
2. [Connect a client]({% link clients.md %}) with `Authorization: Bearer`.
3. Turn on the tools you want in the [endpoint gateway]({% link gateway.md %}).
4. Ask the client to use the [tools]({% link tools/index.md %}).

## What you can do

- Each Kanboard user has their own MCP token, limited to their own boards.
- Each user turns on only the tools and resources their role allows. An admin does not edit another person's toggles.
- Read, write, and board changes follow the user's real Kanboard project role.
- Twenty-six tools cover projects, tasks, columns, categories, swimlanes, assignment, due dates, and comments.
- The server uses JSON-RPC 2.0 and negotiates MCP up to version 2025-11-25.

## Requirements

Kanboard 1.2.0 or higher, PHP 7.4 or higher, and MySQL, PostgreSQL, or SQLite. Details are on the [specifications]({% link specifications.md %}) page.

## Project links

- [Releases](https://github.com/alejivo/advanced-kanboard-mcp/releases) ship `ModelContextProtocol-<version>.zip`.
- [Issues](https://github.com/alejivo/advanced-kanboard-mcp/issues) are the place to report problems with this fork.
- [Changelog]({% link changelog.md %}) lists what each version changed.
