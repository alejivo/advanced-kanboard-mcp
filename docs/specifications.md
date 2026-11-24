---
title: Specifications
nav_order: 8
description: Kanboard, PHP, and MCP versions this plugin supports.
---

# Specifications

## Requirements

- **Kanboard:** 1.2.0 or higher
- **PHP:** 7.4 or higher (typed properties and named arguments)
- **Database:** MySQL, PostgreSQL, or SQLite

## Protocol

- **MCP version:** 2025-11-25, with negotiation back to 2024-11-05
- **Transport:** streamable HTTP with JSON-RPC 2.0
- **Capabilities:** tools and resources

## HTTP endpoint

| | |
| --- | --- |
| Handler | `/?controller=ModelContextProtocolController&action=handle&plugin=ModelContextProtocol` |
| Authentication | Per-user bearer token (`Authorization: Bearer`, or `?token=` when URL tokens are allowed) |
| Content-Type | `application/json` |
| Method | POST for MCP operations |

The handler is public in Kanboard's access map. No session cookie is required. The token is the credential.
