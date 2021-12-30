# ExpTech_API GitHub
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
- [資訊](#資訊)
- [開始](#開始)
  - [使用服務](#使用服務)
- [範例](#範例)
  - [注意](#注意)
  - [OnlinePost](#OnlinePost)
  - [JavaScript](#JavaScript)
  - [Python](#Python)
  - [Java](#Java)
- [功能](#功能)
  - [功能列表](#功能列表)
- [貢獻者](#貢獻者)

# 資訊
- 當前 API Version => ```21w52-pre1```
- 當前 FormatVersion => ```1```

# 文檔
## 開始
#### 使用服務
* 1.獲取 API Key 詳情請參考 [這裡](https://github.com/ExpTechTW/ExpTech_Discord_Bot)

## 範例
### 注意
- 請務必使用最新的 FormatVersion 來請求服務

#### [OnlinePost](https://reqbin.com/)
- 選 POST 模式
- APIhost 
```http://150.117.110.118:10150/```
- content-type 選 application/x-www-form-urlencoded
- 複製下方文字到 Content
```
APIkey=<放你的 API Key>&&Function=et&&Type=urlchecker&&FormatVersion=1&&Url=免費nitro?http://discord-gifft.com
```

#### JavaScript
```javascript
const axios = require('axios')

let APIhost = "http://150.117.110.118:10150/"
let APIkey = "放入你的 API Key"
let FormatVersion = 1
let Data =
    "APIkey=" + APIkey +
    "&&Function=et" +
    "&&Type=urlchecker" +
    "&&FormatVersion=" + FormatVersion +
    "&&Url=免費nitro?http://discord-gifft.com"

axios
    .post(APIhost, Data)
    .then(res => {
        if (res.data["state"] === "Success") {
            if (res.data["response"] === "undefined") {
                console.log("文本中沒有檢測到網址")
            }
            else if (res.data["response"].lenght != 0) {
                console.log("文本中含有危險網址")
            }
            else {
                console.log("文本中沒有危險網址")
            }
        } else {
            console.log(`錯誤: ${res.data["response"]}`)
        }
    })
```

#### Python
```python
import requests

APIhost = "http://150.117.110.118:10150/"
APIkey = "放入你的 API Key"
FormatVersion = 1

Data = "APIkey="+APIkey+"&&Function=et"+"&&Type=urlchecker" + "&&FormatVersion=" + FormatVersion + "&&Url=免費nitro?http://discord-gifft.com"

header = {"content-type": "application/x-www-form-urlencoded"}

response = requests.post(APIhost, data=Data.encode('utf-8'), headers=header, verify=False)

Json = response.json()

if Json["state"] == "Success":
    if Json["response"] == "undefined":
        print("文本中沒有檢測到網址")
    elif len(Json["response"]) != 0:
        print("文本中含有危險網址")
    else:
        print("文本中沒有危險網址")
else:
    print("錯誤: {}".format(Json["response"]))

```

#### Java
```java
data="APIkey=<放你的 API Key>&&Function=et&&Type=urlchecker&&FormatVersion=1&&Url=免費nitro?http://discord-gifft.com"
URL url = new URL("http://150.117.110.118:10150/");
HttpURLConnection http = (HttpURLConnection)url.openConnection();
http.setRequestMethod("POST");
http.setDoOutput(true);
http.setConnectTimeout(1000);
http.setRequestProperty("Authorization", "Bearer mt0dgHmLJMVQhvjpNXDyA83vA_PxH23Y");
http.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
byte[] out = data.getBytes(StandardCharsets.UTF_8);
OutputStream stream = http.getOutputStream();
stream.write(out);
String inputLine;
StringBuilder response = new StringBuilder();
if(http.getResponseCode() == 200){
BufferedReader in = new BufferedReader(new InputStreamReader(http.getInputStream()));
while ((inputLine = in .readLine()) != null) {
  response.append(inputLine);
} in .close();
  return response.toString();
}else {
  this.getLogger().warning("API service did not respond");
}
http.disconnect();
```

## 功能
#### 功能列表
##### [et](#et)
- [urlChecker](#urlchecker)

# et
### urlChecker
- 加入版本: 21w52-pre1
- 說明: 用來檢測惡意網址的功能
- Port: ```10000```
- Value: ```Url=<url>```
- Response: ```Array``` ```All URL inspections passed``` ```No URL found```

# 貢獻者
* whes1015 - 程式開發
