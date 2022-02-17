## 功能列表
#### [et](#et)
- [urlChecker](#urlchecker)
- [md5](#md5)
#### [serverData](#serverData)
- [BlockValue](#BlockValue)
- [Inventory](#Inventory)
- [Statistic](#Statistic)
#### [economy](#economy)
- [assets](#assets)

# et
### urlChecker
- 加入版本: 21w52-pre1
- 傳輸協定: `POST (HTTP)`
- 說明: 用來檢測惡意網址的功能
- FormatVersion: ```1```
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
- 加入版本: 22w01-pre2
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
- 加入版本: 22w04-pre1 ( 棄用 22w05-pre1 由 [Statistic](#Statistic) 取代 )
- 傳輸協定: `POST (HTTP)`
- 說明: 用來獲取玩家方塊挖掘統計的功能
- FormatVersion: ```1```
- 附加參數: ```ServerUUID```
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
- 加入版本: 22w04-pre1
- 傳輸協定: `POST (HTTP)`
- 說明: 用來獲取玩家背包物品詳情的功能
- FormatVersion: ```1```
- 附加參數: ```ServerUUID```
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
- 加入版本: 22w05-pre1
- 傳輸協定: `POST (HTTP)`
- 說明: 用來獲取玩家各項統計數據的功能
- FormatVersion: ```1```
- 附加參數: ```Addition.type``` ```ServerUUID```
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
