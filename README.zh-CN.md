# OP.GG MCP Server

🇺🇸 [English](./README.md) | 🇰🇷 [한국어](./README.ko.md) | 🇯🇵 [日本語](./README.ja.md) | 🇹🇼 [繁體中文](./README.zh-TW.md) | 🇧🇷 [Português](./README.pt-BR.md)

OP.GG MCP Server 是一个 [Model Context Protocol](https://modelcontextprotocol.io) 实现，让 AI 代理能够访问英雄联盟、云顶之弈(TFT)和无畏契约的 OP.GG 游戏数据。

![opgg-mcp-lol-leaderboard](https://github.com/user-attachments/assets/e89a77e7-0b83-4e20-a660-b16aa2d03fe2)

## 端点

```
https://mcp-api.op.gg/mcp
```

服务器支持 **Streamable HTTP** 传输方式。

## 字段选择

大多数工具需要 `desired_output_fields` 参数来指定返回的字段。这可以减少负载大小并提高响应效率。

### 语法

| 模式 | 说明 | 示例 |
|------|------|------|
| `field` | 单个字段 | `name` |
| `parent.child` | 嵌套字段 | `data.summoner.level` |
| `array[]` | 数组字段 | `champions[]` |
| `array[].field` | 数组项中的字段 | `data.champions[].name` |
| `{a,b,c}` | 同级多个字段 | `{name,title,lore}` |
| `parent.{a,b}` | 多个嵌套字段 | `data.summoner.{level,name}` |
| `array[].{a,b}` | 数组项中的多个字段 | `data.champions[].{name,title}` |

### 示例

```json
{
  "desired_output_fields": [
    "data.summoner.{game_name,tagline,level}",
    "data.summoner.league_stats[].{game_type,win,lose}",
    "data.summoner.league_stats[].tier_info.{tier,division,lp}"
  ]
}
```

## 可用工具

### 英雄联盟

#### 英雄
| 工具 | 说明 |
|------|------|
| `lol_get_champion_analysis` | 获取英雄详细统计（胜率/选取率/禁用率）、最优出装（装备、符文、技能、召唤师技能）、克制关系和团队配合 |
| `lol_get_champion_synergies` | 获取英雄配合信息 |
| `lol_get_lane_matchup_guide` | 获取特定路线的对线指南 |
| `lol_list_champion_details` | 获取最多10个英雄的技能、提示、背景故事和属性元数据 |
| `lol_list_champion_leaderboard` | 获取英雄排行榜数据 |
| `lol_list_champions` | 列出所有英雄元数据 |
| `lol_list_lane_meta_champions` | 获取各路英雄梯队、胜率/选取率/禁用率、KDA和梯队排名 |

#### 召唤师
| 工具 | 说明 |
|------|------|
| `lol_get_summoner_game_detail` | 获取特定比赛的详细信息（所有玩家） |
| `lol_get_summoner_profile` | 获取召唤师资料（段位、等级、LP、胜率、英雄池） |
| `lol_list_summoner_matches` | 获取最近比赛记录和每场统计 |

#### 资源
| 工具 | 说明 |
|------|------|
| `lol_list_discounted_skins` | 获取当前折扣皮肤 |
| `lol_list_items` | 列出所有装备元数据 |

#### 职业选手
| 工具 | 说明 |
|------|------|
| `lol_get_pro_player_riot_id` | 获取职业选手的 Riot ID |

#### 电子竞技
| 工具 | 说明 |
|------|------|
| `lol_esports_list_schedules` | 获取英雄联盟电竞赛程（队伍、联赛、比赛时间） |
| `lol_esports_list_team_standings` | 获取英雄联盟联赛队伍排名 |

### 云顶之弈 (TFT)

| 工具 | 说明 |
|------|------|
| `tft_get_champion_item_build` | 获取棋子装备推荐 |
| `tft_get_play_style` | 获取运营风格推荐 |
| `tft_list_augments` | 获取强化符文列表和说明 |
| `tft_list_champions_for_item` | 获取特定装备适合的棋子推荐 |
| `tft_list_item_combinations` | 获取装备合成配方 |
| `tft_list_meta_decks` | 获取当前版本强势阵容 |

### 无畏契约

| 工具 | 说明 |
|------|------|
| `valorant_list_agent_compositions_for_map` | 获取特定地图的特工组合 |
| `valorant_list_agent_statistics` | 获取特工统计和元数据 |
| `valorant_list_agents` | 获取特工元数据（技能、职责） |
| `valorant_list_leaderboard` | 获取各区域排行榜（ap, br, eu, kr, latam, na） |
| `valorant_list_maps` | 获取地图元数据 |
| `valorant_list_player_matches` | 获取玩家比赛记录 |

## 许可证

本项目采用 MIT 许可证。详情请参阅 LICENSE 文件。

## 相关链接

- [Model Context Protocol](https://modelcontextprotocol.io)
- [OP.GG](https://op.gg)
