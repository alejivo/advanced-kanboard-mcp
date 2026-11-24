# Advanced Kanboard MCP

[![Kanboard](https://img.shields.io/badge/kanboard-1.2.0+-green.svg)](https://kanboard.org/)
[![MCP](https://img.shields.io/badge/MCP-2025--11--25-orange.svg)](https://modelcontextprotocol.io/)

An MCP that connects autonomous agents, such as Cursor and Claude, to Kanboard. Each agent gets granular access to specific boards. Another plugin will interact with this one. The [About](docs/about.md) page explains that.

Each release attaches a Kanboard plugin archive named `ModelContextProtocol-<version>.zip`.

## Documentation

The guide is published at <https://alejivo.github.io/advanced-kanboard-mcp/>.

| | |
| --- | --- |
| [About](docs/about.md) | Agents, granular board access, and the plugin that will use this one |
| [Installation](docs/installation.md) | Install the zip and generate a token |
| [Clients](docs/clients.md) | Cursor, Claude, and bearer-token configuration |
| [Tools](docs/tools/index.md) | The 26 tools and two resources |
| [Security](docs/security.md) | Tokens, roles, and transport |
| [Endpoint gateway](docs/gateway.md) | Per-user tool toggles |
| [Specifications](docs/specifications.md) | Versions and the HTTP endpoint |
| [Changelog](docs/changelog.md) | What each release changed |
| [Videos](docs/videos.md) | Integrations, tokens, and the endpoint gateway |

## Install

1. Download `ModelContextProtocol-<version>.zip` from [Releases](https://github.com/alejivo/advanced-kanboard-mcp/releases) and extract `ModelContextProtocol/` into Kanboard's `plugins/` folder.
2. Enable the plugin under **Settings → Plugins**.
3. Each user generates their own token under **Settings → Integrations** or their profile **→ Integrations**.

Client configuration, the endpoint gateway, and the security rules are in the guide.

## Requirements

- Kanboard 1.2.0 or higher
- PHP 7.4 or higher
- MySQL, PostgreSQL, or SQLite

## Support

- [GitHub Issues](https://github.com/alejivo/advanced-kanboard-mcp/issues) for this fork
- [Original Kanboard MCP](https://github.com/ChristianJStarr/kanboard-mcp) by Christian Starr
- [Kanboard community](https://kanboard.org/community)
