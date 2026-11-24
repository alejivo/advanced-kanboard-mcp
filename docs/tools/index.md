---
title: Tools
nav_order: 5
has_children: true
has_toc: false
description: Twenty-six MCP tools and two resources for Kanboard.
---

# Tools

The plugin exposes 26 tools and two resources. A tool appears for a user only when their Kanboard role allows it and their [endpoint gateway]({% link gateway.md %}) has it switched on.

| Group | Tools | Who can change data |
| --- | --- | --- |
| [Projects and tasks]({% link tools/projects.md %}) | 8 | Members change tasks. App admins and app managers create projects. |
| [Columns]({% link tools/columns.md %}) | 5 | Project managers change the board. Anyone who can see the project can list columns. |
| [Categories]({% link tools/categories.md %}) | 4 | Project managers. Listing is available to readers. |
| [Swimlanes]({% link tools/swimlanes.md %}) | 4 | Project managers. Listing is available to readers. |
| [Users and assignment]({% link tools/users.md %}) | 5 | Members assign, comment, and set due dates. Listing follows who you can see. |

## Resources

| Resource | Returns |
| --- | --- |
| `kanboard://projects` | Projects the token user can see. The project public-access token is omitted. |
| `kanboard://users` | `id`, `username`, and `name` only. |

Both resources follow the same read permission and gateway switch as the matching list tools. The role table on the [security]({% link security.md %}) page is the full rule set.
