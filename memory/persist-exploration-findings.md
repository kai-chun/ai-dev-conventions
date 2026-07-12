---
name: persist-exploration-findings
description: 完成重要的 call-chain 追蹤、版本 diff 或邏輯分析後，把結論存下來（筆記檔或 memory），讓探索成果跨 session 累積
metadata:
  type: feedback
---

使用者的 session 多數是理解型工作——追 call chain、diff 模組版本、釐清邏輯——但結論在 session 之間流失，導致重複追同樣的東西。完成一次有分量的分析後，要把結論持久化：存成使用者同意的筆記檔，或存成 `project` 型的 memory 摘要被追出來的結構。

**Why:** insights 顯示大宗工作是探索式理解。每個 session 重新推導同樣的 call chain 是浪費。

**How to apply:** 當 session 產出承重的理解（call-chain 圖、版本對版本的 diff 摘要、資料流結論）時，主動提議存檔——或直接以 `project` 型 memory 存一份精簡版，把 session 相對的脈絡改寫成獨立成立的事實。只存結論，不存原始傾倒。
