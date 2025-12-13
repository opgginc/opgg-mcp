# OP.GG MCP Server

🇺🇸 [English](./README.md) | 🇰🇷 [한국어](./README.ko.md) | 🇯🇵 [日本語](./README.ja.md) | 🇨🇳 [简体中文](./README.zh-CN.md) | 🇹🇼 [繁體中文](./README.zh-TW.md)

O OP.GG MCP Server é uma implementação do [Model Context Protocol](https://modelcontextprotocol.io) que permite que agentes de IA acessem dados de jogos do OP.GG para League of Legends, Teamfight Tactics (TFT) e Valorant.

![opgg-mcp-lol-leaderboard](https://github.com/user-attachments/assets/e89a77e7-0b83-4e20-a660-b16aa2d03fe2)

## Endpoint

```
https://mcp-api.op.gg/mcp
```

O servidor suporta transporte **Streamable HTTP**.

## Seleção de Campos

A maioria das ferramentas requer o parâmetro `desired_output_fields` para especificar quais campos retornar. Isso reduz o tamanho do payload e melhora a eficiência da resposta.

### Sintaxe

| Padrão | Descrição | Exemplo |
|--------|-----------|---------|
| `field` | Campo único | `name` |
| `parent.child` | Campo aninhado | `data.summoner.level` |
| `array[]` | Campo de array | `champions[]` |
| `array[].field` | Campo em itens do array | `data.champions[].name` |
| `{a,b,c}` | Múltiplos campos no mesmo nível | `{name,title,lore}` |
| `parent.{a,b}` | Múltiplos campos aninhados | `data.summoner.{level,name}` |
| `array[].{a,b}` | Múltiplos campos em itens do array | `data.champions[].{name,title}` |

### Exemplo

```json
{
  "desired_output_fields": [
    "data.summoner.{game_name,tagline,level}",
    "data.summoner.league_stats[].{game_type,win,lose}",
    "data.summoner.league_stats[].tier_info.{tier,division,lp}"
  ]
}
```

## Ferramentas Disponíveis

### League of Legends

#### Campeões
| Ferramenta | Descrição |
|------------|-----------|
| `lol_get_champion_analysis` | Obter estatísticas detalhadas do campeão (taxas de vitória/escolha/banimento), builds otimizadas (itens, runas, habilidades, feitiços), matchups de counter e sinergias de equipe |
| `lol_get_champion_synergies` | Obter informações de sinergia de campeões |
| `lol_get_lane_matchup_guide` | Obter guia de matchup para uma lane específica |
| `lol_list_champion_details` | Obter metadados de habilidades, dicas, lore e estatísticas para até 10 campeões |
| `lol_list_champion_leaderboard` | Obter dados do ranking de campeões |
| `lol_list_champions` | Listar metadados de todos os campeões |
| `lol_list_lane_meta_champions` | Obter tiers de campeões por lane com taxas de vitória/escolha/banimento, KDA e rankings |

#### Invocadores
| Ferramenta | Descrição |
|------------|-----------|
| `lol_get_summoner_game_detail` | Obter informações detalhadas de uma partida específica (todos os jogadores) |
| `lol_get_summoner_profile` | Obter perfil do invocador com rank, tier, LP, taxa de vitória e pool de campeões |
| `lol_list_summoner_matches` | Obter histórico de partidas recentes com estatísticas por jogo |

#### Recursos
| Ferramenta | Descrição |
|------------|-----------|
| `lol_list_discounted_skins` | Obter skins em promoção |
| `lol_list_items` | Listar metadados de todos os itens |

#### Jogadores Profissionais
| Ferramenta | Descrição |
|------------|-----------|
| `lol_get_pro_player_riot_id` | Obter Riot ID de um jogador profissional |

#### Esports
| Ferramenta | Descrição |
|------------|-----------|
| `lol_esports_list_schedules` | Obter calendário de esports do LoL (times, ligas e horários) |
| `lol_esports_list_team_standings` | Obter classificação dos times em uma liga de LoL |

### Teamfight Tactics (TFT)

| Ferramenta | Descrição |
|------------|-----------|
| `tft_get_champion_item_build` | Obter recomendações de build de itens para campeões |
| `tft_get_play_style` | Obter recomendações de estilo de jogo |
| `tft_list_augments` | Obter lista e descrições de aumentos |
| `tft_list_champions_for_item` | Obter recomendações de campeões para um item específico |
| `tft_list_item_combinations` | Obter receitas de combinação de itens |
| `tft_list_meta_decks` | Obter composições meta atuais |

### Valorant

| Ferramenta | Descrição |
|------------|-----------|
| `valorant_list_agent_compositions_for_map` | Obter composições de agentes para um mapa específico |
| `valorant_list_agent_statistics` | Obter estatísticas e metadados de agentes |
| `valorant_list_agents` | Obter metadados de agentes com habilidades e funções |
| `valorant_list_leaderboard` | Obter ranking por região (ap, br, eu, kr, latam, na) |
| `valorant_list_maps` | Obter metadados de mapas |
| `valorant_list_player_matches` | Obter histórico de partidas do jogador |

## Licença

Este projeto está licenciado sob a Licença MIT - consulte o arquivo LICENSE para detalhes.

## Links Relacionados

- [Model Context Protocol](https://modelcontextprotocol.io)
- [OP.GG](https://op.gg)
