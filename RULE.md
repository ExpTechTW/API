# 索引
- [注意](#注意)
- [規則列表](#規則列表)

## 注意
- 在 請求內容中 加入 `"Info":true` 可獲得 Service Info
```json
{
  "APIkey":"<放入你的 API Key>",
  "Info":true
}
```
- Response
```json5
{
    "state": "Success",
    "response": null,
    "ver": "5.1",
    "service": {
        "state": "Normal", // 服務狀態 [ Normal Unstable Busy Repair ]
        "queue": 0, // API 等待隊列
        "TimeUse": 1, // 從接收到回應費時 (單位 ms)
        "StartTime": 1649154512513, // 接收到請求時的 UNIX 時間戳，可用於計算網路延遲 (單位 ms)
        "EndTime": 1649154512514, // 回應時的 UNIX 時間戳 (單位 ms)
        "Day": 189, // 今日累計服務次數 (所有用戶)
        "Hour": 189, // 上個整點以來累計服務次數 (所有用戶)
        "Speed": 0, // API 調用限速，代表此 APIkey 多少毫秒可以調用一次 API 服務
        "Times": { // 此 APIkey 本日所有使用服務統計
            "times": 189,
            "data-earthquake": 189
        }
    }
}
```

## 規則列表
#### [RDTS](#RDTS) `POST (HTTP)` `WebSocket`
- []() `*`
- []() `*`
- []() `*`
#### [et](#et) `POST (HTTP)`
- [urlChecker](#urlchecker) `*`
- [md5](#md5) `*`
#### [data](#data) `POST (HTTP)`
- [earthquake](#earthquake) `*`
#### [serverData](#serverData) `POST (HTTP)` `棄用`
- [BlockValue](#BlockValue) `*` `棄用`
- [Inventory](#Inventory) `*` `棄用`
- [Statistic](#Statistic) `*` `棄用`

# RDTS
### save
- 傳輸協定: `POST (HTTP)` `WebSocket`
- 說明: 使用 EID 為識別對象的資料儲存功能
- FormatVersion: `1`
- 範例: 
```
{
  "APIkey": "<放入你的 API Key>",
  "Function": "RDTS",
  "Type": "save",
  "FormatVersion": 1,
  "EID": 1,
  "Value": "<欲儲存資料 String Int Json Array>"
}
```
### send
- 傳輸協定: `POST (HTTP)` `WebSocket`
- 說明: 傳送資料到特定 EID 設備的功能
- FormatVersion: `1`
- 範例: 
```
{
  "APIkey": "<放入你的 API Key>",
  "Function": "RDTS",
  "Type": "send",
  "FormatVersion": 1,
  "EID": 1,
  "Value": "<欲傳送資料 String Int Json Array>"
}
```
### get
- 傳輸協定: `POST (HTTP)` `WebSocket`
- 說明: 使用 EID 為識別對象的資料獲取功能
- FormatVersion: `1`
- 範例: 
```
{
  "APIkey": "<放入你的 API Key>",
  "Function": "RDTS",
  "Type": "get",
  "FormatVersion": 1,
  "EID": 1
}
```

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
