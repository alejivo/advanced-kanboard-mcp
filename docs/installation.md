---
title: Installation
nav_order: 3
description: Install the plugin from a release archive and generate a personal MCP token.
---

# Installation

1. Download `ModelContextProtocol-<version>.zip` from [Releases](https://github.com/alejivo/advanced-kanboard-mcp/releases). The archive contains a `ModelContextProtocol` directory. Extract that directory into your Kanboard `plugins/` folder.
2. Sign in to Kanboard as an administrator. Open **Settings → Plugins** and enable the MCP plugin.
3. Open **Settings → Integrations** (admins) or your user profile **→ Integrations** (every user). Click **Autogenerar**, or **Generate Token** the first time.
4. Copy the MCP configuration. The token is shown once. Copy the **Authorization header** client block: the server URL without a token, plus `headers.Authorization: Bearer …`. A URL that embeds `&token=` is also shown for older clients. Prefer the header.

{: .note }
Each user generates their own token. An administrator looking at another user's profile does not see that user's token.

The next step is [connecting a client]({% link clients.md %}). After the client connects, use the [endpoint gateway]({% link gateway.md %}) to choose which tools that token may call.
