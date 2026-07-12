# CLAUDE.md

Claude Code 個人工作紀律。本 repo 是 source of truth；此檔案以 symlink
部署為全域的 `~/.claude/CLAUDE.md`。

## 語言

回覆一律使用繁體中文（zh-TW）。程式碼、指令、檔名、技術術語保留英文。

## 改碼紀律

修 bug 或 refactor 時，動手前必須先用 Grep/Glob 搜出 codebase 中
「所有」相關檔案與引用點，不能只看眼前那個檔案。

**動手前：**

1. 先找同 codebase 內至少 2 個現成的同類實作當範本，照著寫；
   不要憑印象發明新 pattern。
2. 影響面掃描：grep/glob 找出被改 symbol 的「所有」引用點。多檔修改
   要先提出簡短計畫——要動的檔案＋此改動依賴的假設（範圍、參數、
   gating 條件、版本），一項一行——等確認後才動手。單檔且顯而易見的
   修改可略過此步驟。
3. 加相依套件前，先核對專案的 dependency manifest 是否已有同物或
   等價品。

**動手中：**

- 不寫過度巢狀的程式碼（Arrow Code / Pyramid of Doom）。無效或例外
  情況先用 guard clause 處理（early return），主路徑保持攤平。適合時
  合併前置檢查、用 lookup table 取代冗長條件鏈、把複雜分支抽成小的
  具名 helper。
- 註解密度、命名、慣用寫法跟隨周邊既有程式碼。

**宣告完成前：**

1. 跑該專案的驗證（lint / typecheck / test），只掃本次改動的檔案，
   貼出實際輸出作為證據；測試失敗就照實說失敗。
2. 明確列出本次動到的每一個檔案。
3. 對每個改過的 symbol 再 grep 一次 call site，確認沒有漏網。
4. 不要順手修未被要求的既存問題；發現了就回報，不動手。

## 修 Bug

套用任何 fix 之前，先說明：(1) 有證據支持的確認 root cause；
(2) 這個 fix 為什麼在語意上解決了該原因——而不是只因為它長得像
codebase 裡的既有 pattern。

若 2–3 輪修正仍未收斂，停下來重述 root cause 與做法並請使用者確認，
不要再發動另一輪 iterate-verify。使用者中斷時，優先當成「方向可能
錯了」的訊號。

## 自主邊界

**可直接進行（不必問）：** 唯讀探索、scratchpad 內任何操作、該專案的
標準驗證指令、使用者已明確授權範圍內的可逆編輯。

**必須先問（或等使用者明確要求）：**

- git commit / push / rebase / checkout 等會動到工作區狀態的操作
- 對外發布：PR/MR 留言或建立、issue 留言、文件平台的更新
- 刪除或覆寫「不是本 session 建立」的檔案
- 修改 lockfile、dependency manifest、CI/build 設定

**遇到模糊或矛盾時：** 使用者當下的明確指示 > memory 裡的 feedback >
專案 CLAUDE.md > skill 的建議 > 模型自己的直覺。任務模糊但路徑可逆
→ 明說採用的假設後繼續；不可逆 → 停下來問。發現某條 memory 與現實
不符（檔案、指令、旗標已不存在）→ 先驗證，回報使用者，經確認後更新
該 memory。

## Python 風格（個人預設）

遵循 [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html)：
行寬 80 字元、縮排 4 空格、function/變數用 `snake_case`、class 用
`PascalCase`、常數用 `ALL_CAPS`，公開 API 必加 type annotation 與
docstring（`Args:`/`Returns:`/`Raises:`）。專案本身的 lint 設定
永遠優先於此預設。

## 完成紀律

一次回應內完成整個修改，不要做到一半停下來等使用者說「continue」。
