---
name: my-review-lens
description: >
  對已經跑過第一輪 AI review 的 MR/PR diff 進行第二輪個人視角 review 時使用——
  聚焦正確性、可讀性、效能（N+1 query、DB 存取 pattern）與必要性
  （是否存在更輕薄的替代寫法）。人工 review 學到新規則要回寫進本 lens 時
  也使用此 skill。
alwaysApply: false
---

# My Review Lens(個人二輪 review 視角)

## 定位

這是我的個人 review 準則,用於 **第二輪** review。前提假設:MR/PR 作者已經用
AI 跑過第一輪 review,lint 級與淺層問題大多已被抓過。因此本 lens 的價值在於
差異化——只聚焦泛用 AI review 的盲區,寧缺勿濫。

**核心原則:每個 finding 都必須回答「所以呢?」——指出問題的同時,給出具體
替代寫法與 trade-off,否則不要提出。**

## 噪音控制(先讀這段再開始審)

以下一律 **不報**,即使看到也跳過:

- 格式、import 排序、命名風格等 lint 級問題(第一輪已涵蓋)
- 「可以加註解」「可以加 docstring」這類無具體錯誤的建議
- 純粹主觀偏好、且與現有 codebase 慣例不衝突的寫法
- 無法指出具體檔案與行號的泛泛之論

## 四個審查面向

### Lens 1 — 正確性(Correctness)

| 檢查規則 | 常見出錯 pattern |
| --- | --- |
| dict 取值是否會 KeyError | 外部資料/DB document 用 `doc["field"]` 應為 `doc.get("field")` |
| None / 空集合邊界 | 對可能為 None 的回傳值直接鏈式操作、空 list 進入除法或 `[0]` |
| 主資料與衍生寫入的一致性 | audit log / 快取 / 索引表與主資料更新不同步、部分失敗未處理 |
| 例外處理 | `except Exception: pass`、吞掉錯誤後回傳看似成功的結果 |
| 分頁與排序邊界 | skip/limit 邊界、排序欄位缺 index、游標式分頁的重複/遺漏 |

### Lens 2 — 可讀性(Readability)

只報「影響理解正確性」的可讀性問題,不報美觀問題:

- 巢狀超過 2 層的條件 → 改 early return / guard clause
- 一個 function 混雜多個抽象層次(取資料 + 商業邏輯 + 組 response)
- 布林參數導致呼叫端不知其義(`do_thing(True, False)`)→ 建議拆函式或用 enum
- 變數名稱與實際內容不符(`user_list` 其實是 dict)

### Lens 3 — 效能(Performance / N+1)

通用 anti-pattern(依該專案的技術棧對應到具體 API;下表以 DB / RPC 泛稱):

| Anti-pattern | 替代寫法 |
| --- | --- |
| 迴圈內逐筆查詢/更新 DB | 迴圈外用 in-list 一次查齊 / batch write |
| 查詢未指定欄位撈整份紀錄 | 明確指定需要的欄位(projection / select) |
| 先撈全部再在應用層 filter/count | 下推到 query filter / count / aggregation |
| 迴圈內發 RPC / HTTP 呼叫 | 抽成一次性的批次呼叫,先備齊資料再處理 |
| 同一份資料在同一請求內重複查詢 | 上層查一次往下傳 |

### Lens 4 — 必要性(Necessity)

這是本 lens 最重要、也最難被泛用 AI 覆蓋的一項。對 diff 中每個新增的
class / helper / 抽象層 / 依賴,依序問:

1. **現有的共用程式庫或專案內 pattern 能不能做到?** 先 grep 再下結論。
2. **這個新抽象有幾個使用者?** 只有一個 → 質疑是否過早抽象。
3. **刪掉它、用最直白的寫法,會失去什麼?** 答不出來 → 建議刪。

**必要性 finding 的強制格式:** 必須附「更輕薄的替代寫法」+「兩種寫法的
優缺點各至少一條」。只說「建議簡化」而不給替代方案的 finding 不成立。

## Finding 輸出格式

```
#### [LENS-<n>] <短標題>(<面向>|<severity: blocking/suggestion>)
- **File:** `<path>` (line <N>)
- **Rule:** <引用上方哪條規則>
- **Issue:** <具體問題與觸發情境>
- **Alternative:** <具體替代寫法(必要性類必填優缺點比較)>
```

無 finding 時輸出 `_(No personal-lens findings)_`,不要硬湊。

## 誤報反例(False-positive 抑制)

以下情況「看起來像問題但不是」,不要報:

<!-- 每次發現 AI 誤報,就在此加一條反例。格式:
- <看似違反的規則>:<為什麼在此情境下是合理的>(案例:MR/PR 編號)
-->

- (待累積)

## 已驗證案例(規則的出處)

<!-- 累積迴圈:每次人工 review 抓到本 lens 沒抓到的問題,回寫步驟:
1. 在對應 Lens 的表格加一條規則(一行,可執行的判斷)
2. 在此區加案例出處:- <規則摘要>(案例:MR/PR 編號,<一句話描述>)
3. 規則先標 [未驗證],下次 review 該規則成功命中或確認無誤報後移除標記
-->

- (待累積:建議先從最近 3–5 次人工 review 留過的 comment 回填)
 