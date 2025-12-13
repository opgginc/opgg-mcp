# OP.GG MCP Server

🇺🇸 [English](./README.md) | 🇯🇵 [日本語](./README.ja.md) | 🇨🇳 [简体中文](./README.zh-CN.md) | 🇹🇼 [繁體中文](./README.zh-TW.md) | 🇧🇷 [Português](./README.pt-BR.md)

OP.GG MCP Server는 AI 에이전트가 리그 오브 레전드, 전략적 팀 전투(TFT), 발로란트의 OP.GG 게임 데이터에 접근할 수 있도록 하는 [Model Context Protocol](https://modelcontextprotocol.io) 구현체입니다.

![opgg-mcp-lol-leaderboard](https://github.com/user-attachments/assets/e89a77e7-0b83-4e20-a660-b16aa2d03fe2)

## 엔드포인트

```
https://mcp-api.op.gg/mcp
```

**Streamable HTTP** 전송 방식을 지원합니다.

## 필드 선택

대부분의 도구는 반환할 필드를 지정하는 `desired_output_fields` 파라미터가 필수입니다. 이를 통해 페이로드 크기를 줄이고 응답 효율성을 높일 수 있습니다.

### 문법

| 패턴 | 설명 | 예시 |
|------|------|------|
| `field` | 단일 필드 | `name` |
| `parent.child` | 중첩 필드 | `data.summoner.level` |
| `array[]` | 배열 필드 | `champions[]` |
| `array[].field` | 배열 항목 내 필드 | `data.champions[].name` |
| `{a,b,c}` | 같은 레벨의 여러 필드 | `{name,title,lore}` |
| `parent.{a,b}` | 여러 중첩 필드 | `data.summoner.{level,name}` |
| `array[].{a,b}` | 배열 항목 내 여러 필드 | `data.champions[].{name,title}` |

### 예시

```json
{
  "desired_output_fields": [
    "data.summoner.{game_name,tagline,level}",
    "data.summoner.league_stats[].{game_type,win,lose}",
    "data.summoner.league_stats[].tier_info.{tier,division,lp}"
  ]
}
```

## 사용 가능한 도구

### 리그 오브 레전드

#### 챔피언
| 도구 | 설명 |
|------|------|
| `lol_get_champion_analysis` | 챔피언 상세 통계(승률/픽률/밴률), 최적 빌드(아이템, 룬, 스킬, 스펠), 카운터 매치업, 팀 시너지 조회 |
| `lol_get_champion_synergies` | 챔피언 시너지 정보 조회 |
| `lol_get_lane_matchup_guide` | 특정 라인의 매치업 가이드 조회 |
| `lol_list_champion_details` | 최대 10개 챔피언의 스킬, 팁, 스토리, 스탯 메타데이터 조회 |
| `lol_list_champion_leaderboard` | 챔피언 리더보드 데이터 조회 |
| `lol_list_champions` | 모든 챔피언 메타데이터 목록 |
| `lol_list_lane_meta_champions` | 라인별 챔피언 티어, 승률/픽률/밴률, KDA, 티어 랭킹 조회 |

#### 소환사
| 도구 | 설명 |
|------|------|
| `lol_get_summoner_game_detail` | 특정 경기의 상세 정보(모든 플레이어) 조회 |
| `lol_get_summoner_profile` | 소환사 프로필(랭크, 티어, LP, 승률, 챔피언 풀) 조회 |
| `lol_list_summoner_matches` | 최근 매치 기록 및 경기별 통계 조회 |

#### 리소스
| 도구 | 설명 |
|------|------|
| `lol_list_discounted_skins` | 현재 할인 중인 스킨 조회 |
| `lol_list_items` | 모든 아이템 메타데이터 목록 |

#### 프로 선수
| 도구 | 설명 |
|------|------|
| `lol_get_pro_player_riot_id` | 프로 선수의 Riot ID 조회 |

#### e스포츠
| 도구 | 설명 |
|------|------|
| `lol_esports_list_schedules` | LoL e스포츠 일정(팀, 리그, 경기 시간) 조회 |
| `lol_esports_list_team_standings` | LoL 리그 팀 순위 조회 |

### 전략적 팀 전투 (TFT)

| 도구 | 설명 |
|------|------|
| `tft_get_champion_item_build` | 챔피언 아이템 빌드 추천 조회 |
| `tft_get_play_style` | 플레이 스타일 추천 조회 |
| `tft_list_augments` | 증강 목록 및 설명 조회 |
| `tft_list_champions_for_item` | 특정 아이템에 적합한 챔피언 추천 조회 |
| `tft_list_item_combinations` | 아이템 조합 레시피 조회 |
| `tft_list_meta_decks` | 현재 메타 덱 조회 |

### 발로란트

| 도구 | 설명 |
|------|------|
| `valorant_list_agent_compositions_for_map` | 특정 맵의 요원 조합 조회 |
| `valorant_list_agent_statistics` | 요원 통계 및 메타 데이터 조회 |
| `valorant_list_agents` | 요원 메타데이터(능력, 역할) 조회 |
| `valorant_list_leaderboard` | 지역별 리더보드 조회 (ap, br, eu, kr, latam, na) |
| `valorant_list_maps` | 맵 메타데이터 조회 |
| `valorant_list_player_matches` | 플레이어 매치 기록 조회 |

## 라이선스

이 프로젝트는 MIT 라이선스로 배포됩니다. 자세한 내용은 LICENSE 파일을 참조하세요.

## 관련 링크

- [Model Context Protocol](https://modelcontextprotocol.io)
- [OP.GG](https://op.gg)
