# ExpTech API
<img alt="Discord" src="https://img.shields.io/discord/926545182407688273">

------

- 這是一個由 ExpTech.tw 開發的集成 API 服務
- 官方 [Discord](https://discord.gg/5dbHqV8ees)

## 索引
- [資訊](#資訊)
- [注意](#注意)
- [文檔](#文檔)
- [貢獻者](#貢獻者)
- [項目](#項目)
- [發佈規則](#發佈規則)
- [合作](#合作)

## 資訊
#### 服務器
- `http://exptech.com.tw/post` | **POST No SSL**
- `https://exptech.com.tw/post` | **POST SSL**
- `http://exptech.com.tw/get` | **GET No SSL**
- `https://exptech.com.tw/get` | **GET SSL**
- `ws://exptech.com.tw/websocket` | **Websocket No SSL**
- `wss://exptech.com.tw/websocket` | **Websocket SSL**

#### [服務器 即時狀態](https://stats.uptimerobot.com/KElQPHqKVk)

## 注意
- 此 API 為 固定 IP DDNS 非必須
- DDNS 會導致 150+ms 的查詢延遲 自行評估使用
- 獲取 API Key 請前往 [這裡](http://150.117.110.118/service/)
- 每個 API Key 每日請求上限次數為 50000 次
- 每個 IP 每秒超過 100 次請求會觸發 懲罰性限速 50ms 為期一小時
- 每個 IP 每秒超過 200 次請求會觸發 懲罰性限速 100ms 為期一小時
- 每個 IP 每秒超過 350 次請求會觸發 懲罰性限速 500ms 為期一小時
- 每個 IP 每秒超過 500 次請求會觸發 IP封鎖 為期一小時
- `APIkey` `Function` `Type` `FormatVersion` 為必須參數
##### `POST (HTTP)`
- 
##### `WebSocket`
- `UUID` 為 `WebSocket` 除上述參數之外還額外需要的 必須參數

## 文檔
- [規則文檔](https://github.com/ExpTechTW/API/blob/master/RULE.md)
- [格式文檔](https://github.com/ExpTechTW/API/blob/master/FORMAT.md)
- [程式文檔](https://github.com/ExpTechTW/API/blob/master/CODE.md)

## 貢獻者
- whes1015 `程式開發` `附加資料庫` `文檔`
- jiajun190808 `附加資料庫`
- darian-YT `附加資料庫`
- smile-minecraft `附加資料庫` `第三方合作伙伴`

## 項目
#### WebSocket
##### `ExpTech`
- [ET_Smart_Socket](https://github.com/ExpTechTW/ET_Smart_Socket)
-----
#### POST (HTTP)
##### `ExpTech`
- [DWHS](https://github.com/ExpTechTW/DWHS)
- [ExpTech_Service](https://github.com/ExpTechTW/ExpTech_Service)
- [ExpTech-Home](https://github.com/ExpTechTW/ExpTech-Home)
- [Answer](https://github.com/ExpTechTW/Answer)
- [ExpTech_Website](https://github.com/ExpTechTW/ExpTech_Website)
- [ExpTech_Core](https://github.com/ExpTechTW/ExpTech_Core)
  - [ExpTech_Economy](https://github.com/ExpTechTW/ExpTech_Economy)
  - [ExpTech_DataRecord](https://github.com/ExpTechTW/ExpTech_DataRecord)
  - [ExpTech_BanSystem](https://github.com/ExpTechTW/ExpTech_BanSystem)
  - [ExpTech_Here](https://github.com/ExpTechTW/ExpTech_Here)
  - [ExpTech_Organization](https://github.com/ExpTechTW/ExpTech_Organization)
  - [ExpTech_FreeCamera](https://github.com/ExpTechTW/ExpTech_FreeCamera)
- [ExpTech_DC_Bot](https://github.com/ExpTechTW/ExpTech_DC_Bot)
- [ExpTech_Discord_Bot](https://github.com/ExpTechTW/ExpTech_Discord_Bot)
##### `第三方合作伙伴`
- [bot](https://github.com/smile-minecraft/bot) `smile-minecraft`

## 發佈規則
- 如果新版本中有錯誤，且尚未列出，請將錯誤資訊提交到 ```issue```
- 如果您使用任何形式的辱罵性或貶義性語言給其他用戶，您將永遠被封禁！
- 不要發送重複無意義內容至 ```issue```，否則您將永遠被封禁！
- 若有任何問題或建議，歡迎提出

## 合作
- 若有任何可以改進的地方，歡迎使用 ```Pull requests``` 來提交

