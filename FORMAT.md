##  規則列表
#### [et](#et) `POST (HTTP)`
- [urlChecker](#urlchecker) `POST (HTTP)`

# et
## urlChecker
#### FormatVersion 1
- 狀態: `支援`
```
{
  "APIkey": "<放入你的 API Key>",
  "Function": "et",
  "Type": "urlChecker",
  "FormatVersion": 1,
  "Value": "<欲檢測文本>"
}
```
#### FormatVersion 2
- 狀態: `支援`
- 向下兼容 FormatVersion `≤1`
- 新增 FuzzyMatch 選項 `默認 false`
- 啟用 FuzzyMatch 可以最大程度的檢測惡意網址
```
{
  "APIkey": "<放入你的 API Key>",
  "Function": "et",
  "Type": "urlChecker",
  "FormatVersion": 2,
  "Value": "<欲檢測文本>",
  "Addition":{
    "FuzzyMatch":true
    }
}
```
