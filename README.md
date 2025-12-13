# OP.GG MCP Server

🇰🇷 [한국어](./README.ko.md) | 🇯🇵 [日本語](./README.ja.md) | 🇨🇳 [简体中文](./README.zh-CN.md) | 🇹🇼 [繁體中文](./README.zh-TW.md) | 🇧🇷 [Português](./README.pt-BR.md)

The OP.GG MCP Server is a [Model Context Protocol](https://modelcontextprotocol.io) implementation that provides AI agents with access to OP.GG game data for League of Legends, Teamfight Tactics, and Valorant.

![opgg-mcp-lol-leaderboard](https://github.com/user-attachments/assets/e89a77e7-0b83-4e20-a660-b16aa2d03fe2)

## Endpoint

```
https://mcp-api.op.gg/mcp
```

The server supports **Streamable HTTP** transport.

## Field Selection

Most tools require a `desired_output_fields` parameter to specify which fields to return. This reduces payload size and improves response efficiency.

### Syntax

| Pattern | Description | Example |
|---------|-------------|---------|
| `field` | Single field | `name` |
| `parent.child` | Nested field | `data.summoner.level` |
| `array[]` | Array field | `champions[]` |
| `array[].field` | Field in array items | `data.champions[].name` |
| `{a,b,c}` | Multiple fields at same level | `{name,title,lore}` |
| `parent.{a,b}` | Multiple nested fields | `data.summoner.{level,name}` |
| `array[].{a,b}` | Multiple fields in array items | `data.champions[].{name,title}` |

### Example

```json
{
  "desired_output_fields": [
    "data.summoner.{game_name,tagline,level}",
    "data.summoner.league_stats[].{game_type,win,lose}",
    "data.summoner.league_stats[].tier_info.{tier,division,lp}"
  ]
}
```

## Available Tools

### League of Legends

#### Champions
| Tool | Description |
|------|-------------|
| `lol_get_champion_analysis` | Get detailed champion stats (win/pick/ban rates), optimal builds (items, runes, skills, spells), counter matchups, and team synergies |
| `lol_get_champion_synergies` | Get champion synergy information |
| `lol_get_lane_matchup_guide` | Get lane matchup guide for a specific lane |
| `lol_list_champion_details` | Get ability, tip, lore, and stat metadata for up to 10 champions |
| `lol_list_champion_leaderboard` | Get champion leaderboard data |
| `lol_list_champions` | List all champion metadata |
| `lol_list_lane_meta_champions` | Get lane-by-lane champion tiers with win/pick/ban rates, KDA, and tier rankings |

#### Summoners
| Tool | Description |
|------|-------------|
| `lol_get_summoner_game_detail` | Get detailed information for a specific game (all players) |
| `lol_get_summoner_profile` | Get summoner profile with rank, tier, LP, win rate, and champion pool |
| `lol_list_summoner_matches` | Get recent match history with per-game stats |

#### Resources
| Tool | Description |
|------|-------------|
| `lol_list_discounted_skins` | Get currently discounted skins |
| `lol_list_items` | List all item metadata |

#### Pro Players
| Tool | Description |
|------|-------------|
| `lol_get_pro_player_riot_id` | Get Riot ID for a pro player |

#### Esports
| Tool | Description |
|------|-------------|
| `lol_esports_list_schedules` | Get upcoming LoL esports schedules with teams, leagues, and match times |
| `lol_esports_list_team_standings` | Get team standings for a LoL league |

### Teamfight Tactics (TFT)

| Tool | Description |
|------|-------------|
| `tft_get_champion_item_build` | Get champion item build recommendations |
| `tft_get_play_style` | Get play style recommendations |
| `tft_list_augments` | Get augment list and descriptions |
| `tft_list_champions_for_item` | Get champion recommendations for a specific item |
| `tft_list_item_combinations` | Get item combination recipes |
| `tft_list_meta_decks` | Get current meta decks |

### Valorant

| Tool | Description |
|------|-------------|
| `valorant_list_agent_compositions_for_map` | Get agent compositions for a specific map |
| `valorant_list_agent_statistics` | Get agent statistics and meta data |
| `valorant_list_agents` | Get agent metadata with abilities and roles |
| `valorant_list_leaderboard` | Get leaderboard by region (ap, br, eu, kr, latam, na) |
| `valorant_list_maps` | Get map metadata |
| `valorant_list_player_matches` | Get player match history |

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Related Links

- [Model Context Protocol](https://modelcontextprotocol.io)
- [OP.GG](https://op.gg)
