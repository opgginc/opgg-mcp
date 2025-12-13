# OP.GG MCP Server

🇺🇸 [English](./README.md) | 🇰🇷 [한국어](./README.ko.md) | 🇨🇳 [简体中文](./README.zh-CN.md) | 🇹🇼 [繁體中文](./README.zh-TW.md) | 🇧🇷 [Português](./README.pt-BR.md)

OP.GG MCP Serverは、AIエージェントがリーグ・オブ・レジェンド、チームファイト タクティクス(TFT)、VALORANTのOP.GGゲームデータにアクセスできるようにする[Model Context Protocol](https://modelcontextprotocol.io)の実装です。

![opgg-mcp-lol-leaderboard](https://github.com/user-attachments/assets/e89a77e7-0b83-4e20-a660-b16aa2d03fe2)

## エンドポイント

```
https://mcp-api.op.gg/mcp
```

**Streamable HTTP**トランスポートをサポートしています。

## フィールド選択

ほとんどのツールでは、返却するフィールドを指定する`desired_output_fields`パラメータが必須です。これによりペイロードサイズを削減し、レスポンス効率を向上させることができます。

### 構文

| パターン | 説明 | 例 |
|----------|------|-----|
| `field` | 単一フィールド | `name` |
| `parent.child` | ネストされたフィールド | `data.summoner.level` |
| `array[]` | 配列フィールド | `champions[]` |
| `array[].field` | 配列要素内のフィールド | `data.champions[].name` |
| `{a,b,c}` | 同じレベルの複数フィールド | `{name,title,lore}` |
| `parent.{a,b}` | 複数のネストされたフィールド | `data.summoner.{level,name}` |
| `array[].{a,b}` | 配列要素内の複数フィールド | `data.champions[].{name,title}` |

### 例

```json
{
  "desired_output_fields": [
    "data.summoner.{game_name,tagline,level}",
    "data.summoner.league_stats[].{game_type,win,lose}",
    "data.summoner.league_stats[].tier_info.{tier,division,lp}"
  ]
}
```

## 利用可能なツール

### リーグ・オブ・レジェンド

#### チャンピオン
| ツール | 説明 |
|--------|------|
| `lol_get_champion_analysis` | チャンピオンの詳細統計（勝率/ピック率/バン率）、最適ビルド（アイテム、ルーン、スキル、スペル）、カウンターマッチアップ、チームシナジーを取得 |
| `lol_get_champion_synergies` | チャンピオンシナジー情報を取得 |
| `lol_get_lane_matchup_guide` | 特定レーンのマッチアップガイドを取得 |
| `lol_list_champion_details` | 最大10体のチャンピオンのスキル、ヒント、ストーリー、ステータスメタデータを取得 |
| `lol_list_champion_leaderboard` | チャンピオンリーダーボードデータを取得 |
| `lol_list_champions` | 全チャンピオンのメタデータ一覧 |
| `lol_list_lane_meta_champions` | レーン別チャンピオンティア、勝率/ピック率/バン率、KDA、ティアランキングを取得 |

#### サモナー
| ツール | 説明 |
|--------|------|
| `lol_get_summoner_game_detail` | 特定の試合の詳細情報（全プレイヤー）を取得 |
| `lol_get_summoner_profile` | サモナープロフィール（ランク、ティア、LP、勝率、チャンピオンプール）を取得 |
| `lol_list_summoner_matches` | 最近のマッチ履歴と試合ごとの統計を取得 |

#### リソース
| ツール | 説明 |
|--------|------|
| `lol_list_discounted_skins` | 現在割引中のスキンを取得 |
| `lol_list_items` | 全アイテムのメタデータ一覧 |

#### プロプレイヤー
| ツール | 説明 |
|--------|------|
| `lol_get_pro_player_riot_id` | プロプレイヤーのRiot IDを取得 |

#### eスポーツ
| ツール | 説明 |
|--------|------|
| `lol_esports_list_schedules` | LoL eスポーツスケジュール（チーム、リーグ、試合時間）を取得 |
| `lol_esports_list_team_standings` | LoLリーグのチーム順位を取得 |

### チームファイト タクティクス (TFT)

| ツール | 説明 |
|--------|------|
| `tft_get_champion_item_build` | チャンピオンアイテムビルド推奨を取得 |
| `tft_get_play_style` | プレイスタイル推奨を取得 |
| `tft_list_augments` | オーグメント一覧と説明を取得 |
| `tft_list_champions_for_item` | 特定アイテムに適したチャンピオン推奨を取得 |
| `tft_list_item_combinations` | アイテム合成レシピを取得 |
| `tft_list_meta_decks` | 現在のメタデッキを取得 |

### VALORANT

| ツール | 説明 |
|--------|------|
| `valorant_list_agent_compositions_for_map` | 特定マップのエージェント構成を取得 |
| `valorant_list_agent_statistics` | エージェント統計とメタデータを取得 |
| `valorant_list_agents` | エージェントメタデータ（アビリティ、ロール）を取得 |
| `valorant_list_leaderboard` | 地域別リーダーボードを取得（ap, br, eu, kr, latam, na） |
| `valorant_list_maps` | マップメタデータを取得 |
| `valorant_list_player_matches` | プレイヤーのマッチ履歴を取得 |

## ライセンス

このプロジェクトはMITライセンスの下で公開されています。詳細はLICENSEファイルをご覧ください。

## 関連リンク

- [Model Context Protocol](https://modelcontextprotocol.io)
- [OP.GG](https://op.gg)
