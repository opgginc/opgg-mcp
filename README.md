# OP.GG MCP Server

[![smithery badge](https://smithery.ai/badge/@opgginc/opgg-mcp)](https://smithery.ai/server/@opgginc/opgg-mcp)

The OP.GG MCP Server is a Model Context Protocol implementation that seamlessly connects OP.GG data with AI agents and platforms. This server enables AI agents to retrieve various OP.GG data via function calling.

![opgg-mcp-lol-leaderboard](https://github.com/user-attachments/assets/e89a77e7-0b83-4e20-a660-b16aa2d03fe2)
![opgg-mcp-esports](https://github.com/user-attachments/assets/4e134577-57b6-4369-bb71-b72f1bebcdd8)

## Overview

This MCP server provides AI agents with access to OP.GG data through a standardized interface. It offers a simple way to connect to our remote server (https://mcp-api.op.gg/mcp), allowing for easy installation and immediate access to OP.GG data in a format that's easily consumable by AI models and agent frameworks.

## Features

The OP.GG MCP Server currently supports the following tools:

### League of Legends
- **lol-champion-leader-board**: Get ranking board data for League of Legends champions.
- **lol-champion-analysis**: Provides analysis data for League of Legends champions (counter and ban/pick data available in the "weakCounters" field).
- **lol-champion-meta-data**: Retrieves meta data for a specific champion, including statistics and performance metrics.
- **lol-champion-skin-sale**: Retrieves information about champion skins that are currently on sale.
- **lol-summoner-search**: Search for League of Legends summoner information and stats.
- **lol-champion-positions-data**: Retrieves position statistics data for League of Legends champions, including win rates and pick rates by position.
- **lol-summoner-game-history**: Retrieve recent game history for a League of Legends summoner.
- **lol-summoner-renewal**: Refresh and update League of Legends summoner match history and stats.

### Esports (League of Legends)
- **esports-lol-schedules**: Get upcoming LoL match schedules.
- **esports-lol-team-standings**: Get team standings for a LoL league.

### Teamfight Tactics (TFT)
- **tft-meta-trend-deck-list**: TFT deck list tool for retrieving current meta decks.
- **tft-meta-item-combinations**: TFT tool for retrieving information about item combinations and recipes.
- **tft-champion-item-build**: TFT tool for retrieving champion item build information.
- **tft-recommend-champion-for-item**: TFT tool for retrieving champion recommendations for a specific item.
- **tft-play-style-comment**: This tool provides comments on the playstyle of TFT champions.

### Valorant
- **valorant-meta-maps**: Valorant map meta data.
- **valorant-meta-characters**: Valorant character meta data.
- **valorant-leaderboard**: Fetch Valorant leaderboard by region.
- **valorant-agents-composition-with-map**: Retrieve agent composition data for a Valorant map.
- **valorant-characters-statistics**: Retrieve character statistics data for Valorant, optionally filtered by map.
- **valorant-player-match-history**: Retrieve match history for a Valorant player using their game name and tag line.

## Usage

The OP.GG MCP Server can be used with any MCP-compatible client. The following content explains installation methods using Claude Desktop as an example.

### Direct Connection via StreamableHttp

If you want to connect directly to our StreamableHttp endpoint, you can use the `supergateway` package. This provides a simple way to connect to our remote server without having to install the full OP.GG MCP Server.

Add the following to your `claude_desktop_config.json` file:

#### Mac/Linux

```json
{
  "mcpServers": {
    "opgg-mcp": {
      "command": "npx",
      "args": [
        "-y",
        "supergateway",
        "--streamableHttp",
        "https://mcp-api.op.gg/mcp"
      ]
    }
  }
}
```

#### Windows

```json
{
  "mcpServers": {
    "opgg-mcp": {
      "command": "cmd",
      "args": [
        "/c",
        "npx",
        "-y",
        "supergateway",
        "--streamableHttp",
        "https://mcp-api.op.gg/mcp"
      ]
    }
  }
}
```

This configuration will use the `supergateway` package to establish a direct connection to our StreamableHttp endpoint, providing you with immediate access to all OP.GG data tools.

### Installing via Smithery

To install OP.GG MCP for Claude Desktop automatically via [Smithery](https://smithery.ai/server/@opgginc/opgg-mcp):

```bash
$ npx -y @smithery/cli@latest install @opgginc/opgg-mcp --client claude --key {SMITHERY_API_KEY}
```

### Adding to MCP Configuration

To add this server to your Claude Desktop MCP configuration, add the following entry to your `claude_desktop_config.json` file:

#### Mac/Linux

```json
{
  "mcpServers": {
    "opgg-mcp": {
      "command": "npx",
      "args": [
        "-y",
        "@smithery/cli@latest",
        "run",
        "@opgginc/opgg-mcp",
        "--key",
        "{SMITHERY_API_KEY}"
      ]
    }
  }
}
```

#### Windows

```json
{
  "mcpServers": {
    "opgg-mcp": {
      "command": "cmd",
      "args": [
        "/c",
        "npx",
        "-y",
        "@smithery/cli@latest",
        "run",
        "@opgginc/opgg-mcp",
        "--key",
        "{SMITHERY_API_KEY}"
      ]
    }
  }
}
```

After adding the configuration, restart Claude Desktop for the changes to take effect.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Related Links

- [Model Context Protocol](https://modelcontextprotocol.io)
- [OP.GG](https://op.gg)
