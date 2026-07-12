# Memory Index

## 語言
- [回覆使用中文](reply-in-chinese.md) — 回覆一律使用繁體中文（zh-TW）

## 每次動手前先看的紀律
- [改碼紀律](feedback_code_change_doctrine.md) — 動手前找 2 個範例＋影響面掃描；收尾必列檔案清單、重掃 call site、跑驗證
- [升級規則](feedback_escalation_rules.md) — 可自主 vs 必須先問的邊界；指令衝突時的優先序
- [動手前確認範圍與假設](confirm-scope-and-assumptions-before-editing.md) — 多檔修改前 grep 所有引用點，列出目標檔案＋假設清單，等確認再動手

## 修 bug 與迭代
- [先確認 root cause 再修](verify-root-cause-before-fix.md) — 每個 fix 必須說明確認過的 root cause 與語意正確性，不是照抄 pattern
- [迭代太久要停下重新對齊](stop-and-realign-when-iterating-too-long.md) — 修正 2–3 輪未收斂就停下重新確認方向，不要再疊驗證

## 工作方式
- [持久化探索結論](persist-exploration-findings.md) — 重要的 call-chain 追蹤或版本 diff 結論要存下來，讓理解工作跨 session 累積
- [不要污染 uv.lock](feedback_uv_run_frozen.md) — uv run 一律加 --frozen/--no-sync；先確認工具裝在哪一層再選執行方式
