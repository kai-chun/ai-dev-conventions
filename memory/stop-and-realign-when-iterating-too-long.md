---
name: stop-and-realign-when-iterating-too-long
description: 任務迭代太多輪時使用者會中斷——那代表浪費 token 且方向可能錯了；此時要停下重新確認做法，而不是再疊驗證
metadata:
  type: feedback
---

當使用者中斷某個驗證或修飾步驟時，真正的原因通常是整個迴圈已經迭代太多次——浪費 token——而且方向感覺不對。重點不在被中斷的那個工具（lint、ruff 等）本身。

**Why:** 使用者在 2026-07-03 檢視 insights 時直接說明了這點：當時的結論把中斷誤讀成「對某個驗證工具的偏好」。在錯誤方向上長時間 iterate-verify 只會燒 token 而沒有進展。

**How to apply:** (1) 若 2–3 輪修正仍未收斂，停下來重述 root cause 與做法請使用者確認，不要再發動另一輪 iterate-verify。(2) 不要在已經偏航的 session 尾端追加重量級驗證（lint、完整測試、額外打磨）——方向確認後驗證一次即可。(3) 把使用者的中斷當成「做法可能錯了」的訊號，而不只是「某個 tool call 不被需要」。相關：[[verify-root-cause-before-fix]]——一開始就釘準 root cause，正是避免這種長迴圈的方法。
