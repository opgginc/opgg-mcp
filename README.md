# OP.GG MCP Server

[![smithery badge](https://smithery.ai/badge/@opgginc/opgg-mcp)](https://smithery.ai/server/@opgginc/opgg-mcp)

The OP.GG MCP Server is a Model Context Protocol implementation that seamlessly connects OP.GG data with AI agents and platforms. This server enables AI agents to retrieve various OP.GG data via function calling.

![OP.GG MCP LoL Leaderboard Demo](./opgg-mcp-shorts-1.gif)

![OP.GG MCP Esports Demo](./opgg-mcp-shorts-2.gif)

## Overview

This MCP server provides AI agents with access to OP.GG data through a standardized interface. Built on TypeScript and Node.js, it connects directly to the OP.GG API and formats the data in a way that's easily consumable by AI models and agent frameworks.

## Features

The OP.GG MCP Server currently supports the following tools:

### League of Legends
- **lol-champion-analysis**: Fetch analysis data for a specific champion
- **lol-champion-leader-board**: Fetch that champion's rank

### Esports (League of Legends)
- **esports-lol-schedules**: Get upcoming LoL match schedules
- **esports-lol-team-standings**: Get team standings for a LoL league

### Teamfight Tactics (TFT)
- **tft-meta-trend-deck-list**: TFT deck list tool for retrieving current meta decks
- **tft-meta-item-combinations**: TFT tool for retrieving information about item combinations and recipes
- **tft-champion-item-build**: TFT tool for retrieving champion item build information
- **tft-recommend-champion-for-item**: TFT tool for retrieving champion recommendations for a specific item
- **tft-play-style-comment**: This tool provides comments on the playstyle of TFT champions

### Valorant
- **valorant-meta-maps**: Valorant map meta data
- **valorant-meta-characters**: Valorant character meta data
- **valorant-leaderboard**: Fetch Valorant leaderboard by region
- **valorant-agents-composition-with-map**: Retrieve agent composition data for a Valorant map
- **valorant-characters-statistics**: Retrieve character statistics data for Valorant, optionally filtered by map
- **valorant-player-matches**: Retrieve match history for a Valorant player using their game name and tag line

## Installation

### Installing via Smithery

To install OP.GG MCP for Claude Desktop automatically via [Smithery](https://smithery.ai/server/@opgginc/opgg-mcp):

```bash
npx -y @smithery/cli install @opgginc/opgg-mcp --client claude
```

### Adding to MCP Configuration

**Note:** If you've cloned the repository or made any changes to the code, you may need to build the project first by running `npm run build` before adding it to your MCP configuration.

#### For Claude Desktop

To add this server to your Claude Desktop MCP configuration, add the following entry to your `claude_desktop_config.json` file:

```json
{
  "mcpServers": {
    "opgg-mcp": {
      "command": "node",
      "args": ["/path/to/opgg-mcp/dist/index.js"]
    }
  }
}
```

After adding the configuration, restart Claude Desktop for the changes to take effect.

## Usage

The OP.GG MCP Server can be used with any MCP-compatible client. Here are some examples:

### Listing Available Tools

```json
{ "type": "list_tools" }
```

Response:
```json
{
  "tools": [
    {
      "name": "lol-champion-analysis",
      "description": "Fetch analysis data for a specific champion"
    },
    {
      "name": "lol-champion-leader-board",
      "description": "Fetch that champion's rank"
    },
    {
      "name": "esports-lol-schedules",
      "description": "Get upcoming LoL match schedules"
    },
    {
      "name": "esports-lol-team-standings",
      "description": "Get team standings for a LoL league"
    },
    {
      "name": "tft-meta-trend-deck-list",
      "description": "TFT deck list tool for retrieving current meta decks"
    },
    {
      "name": "tft-meta-item-combinations",
      "description": "TFT tool for retrieving information about item combinations and recipes"
    },
    {
      "name": "tft-champion-item-build",
      "description": "TFT tool for retrieving champion item build information"
    },
    {
      "name": "tft-recommend-champion-for-item",
      "description": "TFT tool for retrieving champion recommendations for a specific item"
    },
    {
      "name": "tft-play-style-comment",
      "description": "This tool provides comments on the playstyle of TFT champions"
    },
    {
      "name": "valorant-meta-maps",
      "description": "Valorant map meta data"
    },
    {
      "name": "valorant-meta-characters",
      "description": "Valorant character meta data"
    },
    {
      "name": "valorant-leaderboard",
      "description": "Fetch Valorant leaderboard by region"
    },
    {
      "name": "valorant-agents-composition-with-map",
      "description": "Retrieve agent composition data for a Valorant map"
    },
    {
      "name": "valorant-characters-statistics",
      "description": "Retrieve character statistics data for Valorant, optionally filtered by map"
    },
    {
      "name": "valorant-player-matches",
      "description": "Retrieve match history for a Valorant player using their game name and tag line"
    }
  ]
}
```

### Example Tool Usage

#### League of Legends Example

```json
{
  "type": "tool_call",
  "tool_call": {
    "name": "lol-champion-analysis"
  }
}
```

Response:
```json
{
  "content": [
    {
      "type": "text",
      "text": "Champion Analysis for Ahri:\n\nTier: A\nWin Rate: 51.2%\nPick Rate: 8.5%\nBan Rate: 4.3%\nBest Runes: Electrocute, Sudden Impact, Eyeball Collection, Relentless Hunter\nBest Items: Luden's Echo, Sorcerer's Shoes, Zhonya's Hourglass\n---\n..."
    }
  ]
}
```

#### Esports Example

```json
{
  "type": "tool_call",
  "tool_call": {
    "name": "esports-lol-schedules"
  }
}
```

Response:
```json
{
  "content": [
    {
      "type": "text",
      "text": "Upcoming match schedules:\n\nMatch: Team A vs Team B\nLeague: LCK\nStatus: SCHEDULED\nScore: 0 - 0\nScheduled at: 4/6/2025, 7:00:00 PM\nDetails: https://esports.op.gg/matches/12345\n---\n..."
    }
  ]
}
```

#### TFT Example

```json
{
  "type": "tool_call",
  "tool_call": {
    "name": "tft-meta-trend-deck-list"
  }
}
```

Response:
```json
{
  "content": [
    {
      "type": "text",
      "text": "Current TFT Meta Decks:\n\nDeck: Yordle Gunners\nTier: S\nPopularity: 15.2%\nAverage Placement: 3.1\nKey Units: Tristana, Poppy, Rumble\nKey Items: Guinsoo's Rageblade, Infinity Edge, Bloodthirster\n---\n..."
    }
  ]
}
```

#### Valorant Example

```json
{
  "type": "tool_call",
  "tool_call": {
    "name": "valorant-meta-maps"
  }
}
```

Response:
```json
{
  "content": [
    {
      "type": "text",
      "text": "Valorant Map Meta Data:\n\nMap: Ascent\nAttack Win Rate: 48.2%\nDefense Win Rate: 51.8%\nPopular Agent Composition: Jett, Omen, Sova, Killjoy, Sage\n---\n..."
    }
  ]
}
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Related Links

- [Model Context Protocol](https://modelcontextprotocol.com)
- [OP.GG](https://op.gg)
