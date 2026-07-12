---
name: feedback-uv-run-frozen
description: 絕不讓 uv.lock 被副作用改寫——uv run 一律加 --frozen
metadata:
  type: feedback
---

在使用 uv 的 repo 跑指令時，`uv run` 會隱式同步環境並可能改寫 `uv.lock`（某些 pyproject 設定如 `exclude-newer` 會讓 uv「Ignoring existing lockfile」重新解析，造成上百行 lock 變動）。使用者明確不希望 lockfile 被無關變更污染。

**Why:** lockfile 變動與功能修改無關，會混進 diff、難以 review，且可能改到相依版本。

**How to apply:** 用 uv 跑東西時一律加 `--frozen`（或 `--no-sync`），例如 `uv run --frozen python -m pytest ...`。若不慎改到，立即 `git checkout -- uv.lock` 還原。注意：venv 內未安裝的工具（如 lint/typecheck 工具裝在系統層時）不要硬用 `uv run` 跑，先確認該工具實際安裝在哪一層。相關：[[confirm-scope-and-assumptions-before-editing]]
