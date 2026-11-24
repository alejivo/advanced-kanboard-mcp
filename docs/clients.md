---
title: Clients
nav_order: 4
description: Connect Cursor, Claude, or any MCP client with a bearer token.
---

# Clients

Send the token as `Authorization: Bearer`. The URL must not include the token.

```json
{
  "mcpServers": {
    "kanboard": {
      "url": "https://your-kanboard.com/?controller=ModelContextProtocolController&action=handle&plugin=ModelContextProtocol",
      "headers": {
        "Authorization": "Bearer YOUR_TOKEN"
      }
    }
  }
}
```

## Cursor

1. Copy the MCP configuration block from the integrations page.
2. Paste it into Cursor's MCP settings (`.cursor/mcp.json` or the settings UI).
3. Manage your Kanboard boards from the editor.

## Claude Desktop

1. Copy the configuration block from the integrations page.
2. Paste it into Claude Desktop's MCP server configuration (`claude_desktop_config.json`).
3. Manage your projects from the Claude conversation.

## Other MCP clients

The plugin works with any MCP client and negotiates protocol versions up to 2025-11-25. Use the same URL and bearer header.

## URL tokens

Some clients only accept a URL. That form puts the secret in the query string:

```
https://your-kanboard.com/?controller=ModelContextProtocolController&action=handle&plugin=ModelContextProtocol&token=YOUR_TOKEN
```

{: .warning }
Web servers and reverse proxies often write the full request URL, including `?token=`, to access logs. Do not treat this path as private.

Administrators can check **Disable token in URL (query string)** on **Settings → Integrations**. While that setting is on, `?token=` is ignored and only `Authorization: Bearer` authenticates. The compatibility block stays visible so you can see why an old URL stopped working.

See [Security]({% link security.md %}) for how header and query-string tokens interact.
