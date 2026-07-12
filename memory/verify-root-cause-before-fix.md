---
name: verify-root-cause-before-fix
description: 套用任何 fix 前，先說明真正的 root cause 並確認 fix 在語意上正確——不是只照抄既有 pattern
metadata:
  type: feedback
---

套用任何 bug fix 之前，先說明真正的 root cause，並確認 fix 在語意上正確——不是只從 codebase 照抄一個看起來像的既有 pattern。

**Why:** 過去的 session 曾因「照抄 pattern、未做語意驗證」而把 bug 直接送出（例如把開啟/不支援的判斷邏輯寫反、test fixture 的 `expired_at` 從未真正被 assert）。當 fix 只做到表面 pattern 吻合時，使用者會反問「你有看到真正的問題嗎？」。

**How to apply:** 提出 fix 時要說明：(1) 有證據支持的確認 root cause；(2) 這個 fix 為什麼在語意上（而非只是語法上）解決了該原因。若 fix 是模仿既有程式碼寫的，套用前要明確驗證被抄的 pattern 在新情境下語意仍然成立。
