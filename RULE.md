## 規則列表
#### [et](#et) `POST (HTTP)`
- [urlChecker](#urlchecker) `POST (HTTP)`
- [md5](#md5) `POST (HTTP)`
#### [data](#data) `POST (HTTP)`
- [earthquake](#earthquake) `POST (HTTP)`
#### [serverData](#serverData) `POST (HTTP)` `棄用`
- [BlockValue](#BlockValue) `POST (HTTP)` `棄用`
- [Inventory](#Inventory) `POST (HTTP)` `棄用`
- [Statistic](#Statistic) `POST (HTTP)` `棄用`

# et
### urlChecker
- 傳輸協定: `POST (HTTP)`
- 說明: 用來檢測惡意網址的功能
- [FormatVersion](https://github.com/ExpTechTW/API/blob/%E4%B8%BB%E8%A6%81%E7%9A%84-(main)/FORMAT.md): `2`  `1`
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

# data
### earthquake
- 傳輸協定: `POST (HTTP)`
- 說明: 用來獲取地震資訊的功能
- FormatVersion: `1`
- 範例: 
```
{
  "APIkey": "<放入你的 API Key>",
  "Function": "data",
  "Type": "earthquake",
  "FormatVersion": 1
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
`棄用 停止支援`
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
`棄用 停止支援`
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
