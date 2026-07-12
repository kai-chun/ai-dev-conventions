---
name: feedback-escalation-rules
description: 何時可自主進行、何時必須停下來問使用者的判斷準則，含指令衝突時的優先序
metadata:
  type: feedback
---

**可直接進行（不必問）：** 唯讀探索（Read/Grep/Glob/git log/diff）、scratchpad 內任何操作、該專案的標準驗證指令、使用者已明確授權範圍內的可逆編輯。

**必須先問（或等使用者明確要求）：**
- git commit / push / rebase / checkout 會動到工作區狀態的操作
- 對外發布：PR/MR 留言或建立、issue 留言、文件平台的建立更新
- 任何正式資料庫的寫入；讀取預設也先列出查詢條件交給使用者
- 刪除或覆寫「不是本 session 建立」的檔案
- 修改 lockfile、dependency manifest、CI/build 設定

**遇到模糊或矛盾時：**
1. 優先序：使用者當下的明確指示 > memory 裡的 feedback > 專案 CLAUDE.md 的預設 > skill 的建議 > 模型自己的直覺。
2. 任務模糊但路徑可逆 → 明說採用的假設後繼續；路徑不可逆 → 停下來問。
3. 發現某條 memory 與現實不符（檔案、指令、旗標已不存在）→ 先驗證，回報使用者，經確認後更新該 memory，不要沿用錯的。

**Why:** 模型最危險的失誤不是「不會做」而是「太敢做」——把不可逆操作當成順手之勞。這份規則把「敢做的邊界」寫死，判斷力不足時就退回到問。
