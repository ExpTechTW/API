# ExpTech_Discord_Bot GitHub
<img alt="Discord" src="https://img.shields.io/discord/857181425908318218">
編程、設計、創意、實用
<br>
努力成為真正的高手
<br />
<p align="center">
  <a href="https://github.com/ExpTech-tw/Example/">
    <img src="image/ExpTech.png" alt="ExpTech" width="150" height="150">
  </a>
  <h3 align="center">ExpTech</h3>
  <p align="center">
    ! 用科技創造無限可能 !
    <br />
    ·
    <a href="https://github.com/ExpTech-tw/Example/issues">錯誤回報</a>
    ·
  </p>
</p>

# 項目概要
* 這是一個由 ExpTech.tw 開發的集成 API
* 官方 [Discord](https://discord.gg/rkPu3msUf3)

# 索引
- [開始](#開始)
  - [註冊服務](#使用服務)
- [權限](#範例)
- [指令](#功能)
  - [指令列表](#功能列表)
- [貢獻者](#貢獻者)

# 資訊
- 當前 API Version => ```21w52-pre1```
- 當前 FormatVersion => ```1```

# 文檔
## 開始
#### 使用服務
* 1.獲取 API Key 詳情請參考 [這裡](https://github.com/ExpTechTW/ExpTech_Discord_Bot)

## 範例
#### discord.js
```javascript
{
  const axios = require('axios')
  
  let APIhost="http://150.117.110.118:10000/"
  let APIkey="放入你的 API Key"
  let Data={
  "Function":"et",
  "Type":"urlchecker",
  "FormatVersion":"當前 FormatVersion 請至 #資訊 查看",
  "value":{
    "url":"http://discord-gifft.com/"
    }
  }
  
  axios
      .post(APIhost,"APIkey="+APIkey+"&&Data="+Data)
      .then(res => {
        if(res.data["response"]==="undefined"){
          console.log("文本中沒有檢測到網址")
        }
        else if(res.data["response"].lenght!=0){
          console.log("文本中含有危險網址")
        } 
        else {
          console.log("文本中沒有危險網址")
        }
      })
}
```

## 功能
#### 功能列表
##### [et](#et)
- [urlchecker](#urlchecker)

# et
### urlchecker
- 加入版本: 21w52-pre1
- 範例請求: 
```json
{
  "Function":"",
  "Type":"",
  "FormatVersion":"當前 FormatVersion 請至 #資訊 查看",
  "value":"免費nitro?\nhttp://discord-gifft.com/"
}
```
- 說明: 用來檢測惡意網址的功能

# 貢獻者
* whes1015 - 程式開發
