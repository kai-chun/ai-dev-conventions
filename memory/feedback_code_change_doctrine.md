---
name: feedback-code-change-doctrine
description: 改碼三階段紀律：動手前找兩個現成範例＋影響面掃描、動手中守分層與風格、收尾必列檔案清單並重掃 call site
metadata:
  type: feedback
---

改碼三階段紀律，每次修改都適用（不限特定 repo）。

**動手前：**
1. 先找「同專案內至少 2 個現成的同類實作」當範本，照著寫；不要憑印象發明新 pattern。
2. 影響面掃描：grep/glob 找出「所有」引用點，列出每個檔案要改什麼，先給計畫再動手（[[confirm-scope-and-assumptions-before-editing]]）。
3. 遵守該專案的分層與架構規範（看該 repo 的 CLAUDE.md / 文件）；可重用邏輯放共用層，不要散落。
4. 加相依套件前，先核對專案的 dependency manifest 是否已有同物或等價品。

**動手中：**
- Early return / guard clause，主路徑保持攤平，不寫 arrow code。
- 行寬、type annotation、docstring 遵循該專案的 lint 設定與風格。
- 註解密度與命名跟隨周邊既有程式碼。

**收尾（宣告完成的必要條件）：**
1. 跑該專案的標準驗證（lint / typecheck / test），只掃本次改動檔案，貼出實際輸出；失敗就照實說。
2. 明確列出「本次動到的每一個檔案」。
3. 對改過的 symbol 再 grep 一次 call site，確認沒有漏網。
4. 不要順手修未被要求的既存問題；發現了就回報，不動手。

**Why:** 多個 session 顯示漏掃引用點、分層錯置、驗證省略是最常被使用者糾正的三類錯誤；把三階段固定成 checklist 可讓任何模型都走同一條安全路徑。
