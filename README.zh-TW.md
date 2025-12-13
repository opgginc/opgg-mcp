# OP.GG MCP Server

🇺🇸 [English](./README.md) | 🇰🇷 [한국어](./README.ko.md) | 🇯🇵 [日本語](./README.ja.md) | 🇨🇳 [简体中文](./README.zh-CN.md) | 🇧🇷 [Português](./README.pt-BR.md)

OP.GG MCP Server 是一個 [Model Context Protocol](https://modelcontextprotocol.io) 實作，讓 AI 代理能夠存取英雄聯盟、聯盟戰棋(TFT)和特戰英豪的 OP.GG 遊戲資料。

![opgg-mcp-lol-leaderboard](https://github.com/user-attachments/assets/e89a77e7-0b83-4e20-a660-b16aa2d03fe2)

## 端點

```
https://mcp-api.op.gg/mcp
```

伺服器支援 **Streamable HTTP** 傳輸方式。

## 欄位選擇

大多數工具需要 `desired_output_fields` 參數來指定回傳的欄位。這可以減少負載大小並提高回應效率。

### 語法

| 模式 | 說明 | 範例 |
|------|------|------|
| `field` | 單一欄位 | `name` |
| `parent.child` | 巢狀欄位 | `data.summoner.level` |
| `array[]` | 陣列欄位 | `champions[]` |
| `array[].field` | 陣列項目中的欄位 | `data.champions[].name` |
| `{a,b,c}` | 同層級多個欄位 | `{name,title,lore}` |
| `parent.{a,b}` | 多個巢狀欄位 | `data.summoner.{level,name}` |
| `array[].{a,b}` | 陣列項目中的多個欄位 | `data.champions[].{name,title}` |

### 範例

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

### 英雄聯盟

#### 英雄
| 工具 | 說明 |
|------|------|
| `lol_get_champion_analysis` | 取得英雄詳細統計（勝率/選取率/禁用率）、最佳出裝（裝備、符文、技能、召喚師技能）、剋制關係和團隊配合 |
| `lol_get_champion_synergies` | 取得英雄配合資訊 |
| `lol_get_lane_matchup_guide` | 取得特定路線的對線指南 |
| `lol_list_champion_details` | 取得最多10個英雄的技能、提示、背景故事和屬性中繼資料 |
| `lol_list_champion_leaderboard` | 取得英雄排行榜資料 |
| `lol_list_champions` | 列出所有英雄中繼資料 |
| `lol_list_lane_meta_champions` | 取得各路英雄梯隊、勝率/選取率/禁用率、KDA和梯隊排名 |

#### 召喚師
| 工具 | 說明 |
|------|------|
| `lol_get_summoner_game_detail` | 取得特定對戰的詳細資訊（所有玩家） |
| `lol_get_summoner_profile` | 取得召喚師資料（牌位、等級、LP、勝率、英雄池） |
| `lol_list_summoner_matches` | 取得最近對戰紀錄和每場統計 |

#### 資源
| 工具 | 說明 |
|------|------|
| `lol_list_discounted_skins` | 取得目前折扣造型 |
| `lol_list_items` | 列出所有裝備中繼資料 |

#### 職業選手
| 工具 | 說明 |
|------|------|
| `lol_get_pro_player_riot_id` | 取得職業選手的 Riot ID |

#### 電子競技
| 工具 | 說明 |
|------|------|
| `lol_esports_list_schedules` | 取得英雄聯盟電競賽程（隊伍、聯賽、比賽時間） |
| `lol_esports_list_team_standings` | 取得英雄聯盟聯賽隊伍排名 |

### 聯盟戰棋 (TFT)

| 工具 | 說明 |
|------|------|
| `tft_get_champion_item_build` | 取得棋子裝備推薦 |
| `tft_get_play_style` | 取得營運風格推薦 |
| `tft_list_augments` | 取得強化符文列表和說明 |
| `tft_list_champions_for_item` | 取得特定裝備適合的棋子推薦 |
| `tft_list_item_combinations` | 取得裝備合成配方 |
| `tft_list_meta_decks` | 取得當前版本強勢陣容 |

### 特戰英豪

| 工具 | 說明 |
|------|------|
| `valorant_list_agent_compositions_for_map` | 取得特定地圖的特務組合 |
| `valorant_list_agent_statistics` | 取得特務統計和中繼資料 |
| `valorant_list_agents` | 取得特務中繼資料（技能、職責） |
| `valorant_list_leaderboard` | 取得各區域排行榜（ap, br, eu, kr, latam, na） |
| `valorant_list_maps` | 取得地圖中繼資料 |
| `valorant_list_player_matches` | 取得玩家對戰紀錄 |

## 授權條款

本專案採用 MIT 授權條款。詳情請參閱 LICENSE 檔案。

## 相關連結

- [Model Context Protocol](https://modelcontextprotocol.io)
- [OP.GG](https://op.gg)
