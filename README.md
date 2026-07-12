# ai-dev-conventions

我的 Claude Code 個人設定源頭版本庫（source of truth）。內容以 symlink
部署到 `~/.claude/`，改這裡的檔案即全域生效。

## 內容

| 目錄/檔案 | 用途 | 部署位置 |
| --- | --- | --- |
| `CLAUDE.md` | 全域工作紀律：語言偏好、改碼三階段、修 bug 準則、自主邊界、Python 風格 | `~/.claude/CLAUDE.md`（symlink） |
| `skills/` | 個人 skills：`mentor`（蘇格拉底引導）、`explain-back`（理解驗證）、`interview-deep-dive`（面試深挖）、`my-review-lens`（二輪 review 視角） | `~/.claude/skills/<name>`（symlink） |
| `memory/` | 行為偏好 memory 的種子檔。Claude Code 的 memory 是 per-project 的，需要時把這些檔案複製/連結到 `~/.claude/projects/<project-slug>/memory/` | 依專案手動 seed |
| `.env.example` | GitHub PAT 範本（供 MCP GitHub server / `gh` CLI） | — |

## 部署

```bash
./deploy.sh
```

腳本是冪等的：建立 `~/.claude/skills/` 下各 skill 的 symlink 與
`~/.claude/CLAUDE.md` 的 symlink；目標已是正確連結時跳過，
是「非 symlink 的既有檔案」時中止並提示，不會覆蓋。

## 維護原則

- 所有調整都改這個 repo 再 commit，不直接改 `~/.claude/` 下的部署目標。
- 新增 skill：在 `skills/<name>/SKILL.md` 建立後重跑 `./deploy.sh`。
- memory 檔遵循 frontmatter 格式（`name` / `description` /
  `metadata.type`），並同步更新 `memory/MEMORY.md` 索引。
