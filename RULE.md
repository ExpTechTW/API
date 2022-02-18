## 規則列表
#### [et](#et) `POST (HTTP)`
- [urlChecker](#urlchecker) `POST (HTTP)`
- [md5](#md5) `POST (HTTP)`
#### [serverData](#serverData) `POST (HTTP)`
- [BlockValue](#BlockValue) `POST (HTTP)`
- [Inventory](#Inventory) `POST (HTTP)`
- [Statistic](#Statistic) `POST (HTTP)`
#### [economy](#economy) `POST (HTTP)`
- [assets](#assets) `POST (HTTP)`

# et
### urlChecker
- 傳輸協定: `POST (HTTP)`
- 說明: 用來檢測惡意網址的功能
- FormatVersion: `2`  `1`
- 範例: 
```
{
  "APIkey": "<放入你的 API Key>",
  "Function": "et",
  "Type": "urlChecker",
  "FormatVersion": 1,
  "Value": "<欲檢測文本>"
}
```

### md5
- 傳輸協定: `POST (HTTP)`
- 說明: 用來計算 md5 值的功能
- FormatVersion: ```1```
- 範例: 
```
{
  "APIkey": "<放入你的 API Key>",
  "Function": "et",
  "Type": "md5",
  "FormatVersion": 1,
  "Value": "<欲 md5 文本>"
}
```


# serverData
### BlockValue
`棄用 由 Statistic 取代`
- 傳輸協定: `POST (HTTP)`
- 說明: 用來獲取玩家方塊挖掘統計的功能
- FormatVersion: ```1```
- 附加參數: ```ServerUUID```
- 依賴: [`ExpTech_Core`](https://github.com/ExpTechTW/ExpTech_Core) [`ExpTech_DataRecord`](https://github.com/ExpTechTW/ExpTech_DataRecord)
- 範例: 
```
{
  "APIkey": "<放入你的 API Key>",
  "Function": "serverData",
  "Type": "BlockValue",
  "FormatVersion": 1,
  "Value": "<欲獲取方塊挖掘統計的玩家 ID/name>"
}
```

### Inventory
- 傳輸協定: `POST (HTTP)`
- 說明: 用來獲取玩家背包物品詳情的功能
- FormatVersion: ```1```
- 附加參數: ```ServerUUID```
- 依賴: [`ExpTech_Core`](https://github.com/ExpTechTW/ExpTech_Core) [`ExpTech_Economy`](https://github.com/ExpTechTW/ExpTech_Economy)
- 範例: 
```
{
  "APIkey": "<放入你的 API Key>",
  "Function": "serverData",
  "Type": "Inventory",
  "FormatVersion": 1,
  "Value": "<欲獲取背包物品詳情的玩家 ID/name>"
}
```

### Statistic
- 傳輸協定: `POST (HTTP)`
- 說明: 用來獲取玩家各項統計數據的功能
- FormatVersion: ```1```
- 附加參數: ```Addition.type``` ```ServerUUID```
- 依賴: [`ExpTech_Core`](https://github.com/ExpTechTW/ExpTech_Core) [`ExpTech_DataRecord`](https://github.com/ExpTechTW/ExpTech_DataRecord)
- 範例: 
```
{
  "APIkey": "<放入你的 API Key>",
  "Function": "serverData",
  "Type": "Statistic",
  "FormatVersion": 1,
  "Value": "<欲獲取方塊挖掘統計的玩家 ID/name>"
}
```
