---
name: confirm-scope-and-assumptions-before-editing
description: 多檔修改前，先 grep 出所有引用點，列出要動的檔案與此改動依賴的假設，等使用者確認再動手
metadata:
  type: feedback
---

任何會動到多個檔案的修改，動手前：先用 Grep/Glob 找出引用目標 function/class/symbol 的「每一個」檔案，然後提出簡短計畫，列出 (1) 確切要改的檔案與各檔要改什麼、(2) 此改動依賴的假設（範圍、參數、gating 條件、版本），等使用者確認後才開始編輯。

**Why:** 使用者最大的摩擦來源是 Claude 在釐清前就猜測範圍或商業邏輯（版本目標錯誤、參數用猜的、邏輯寫反、refactor 時漏掉相關檔案），導致整輪重工與事後反覆糾正。使用者偏好在成本最低的時間點——寫任何程式碼之前——修正方向。

**How to apply:** 只要改動可能波及多個檔案——改名、refactor、加參數、改 base class——就先做完整影響面掃描並以計畫形式提出，檔案與假設各一行。取得明確同意後才編輯。單檔且顯而易見的修改不需要這套儀式。相關：[[verify-root-cause-before-fix]]、[[stop-and-realign-when-iterating-too-long]]。
