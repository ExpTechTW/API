# ExpTech_API GitHub
<img alt="Discord" src="https://img.shields.io/discord/926545182407688273">
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
* 官方 [Discord](https://discord.gg/5dbHqV8ees)

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
  - [PHP](#PHP)
- [功能](#功能)
  - [功能列表](#功能列表)
- [貢獻者](#貢獻者)

# 資訊
- API 主要-服務器 ```http://150.117.110.118:10150/```

# 注意
- 請務必使用最新的 FormatVersion 來請求服務
- ```APIkey``` ```Function``` ```Type``` ```FormatVersion``` 為必須參數

# 文檔
## 開始
#### 使用服務
* 1.獲取 API Key 詳情請參考 [這裡](https://github.com/ExpTechTW/ExpTech_Discord_Bot)

## 範例
#### [OnlinePost](https://reqbin.com/)
- 選 POST 模式
- APIhost 
```http://150.117.110.118:10150/```
- content-type 選 application/json
- 複製下方文字到 Content
```
{
"APIkey":"<放你的 API Key>"
}
```

#### JavaScript
```javascript
const axios = require('axios')

let APIhost = "http://150.117.110.118:10150/"
let APIkey = "放入你的 API Key"
let FormatVersion = 1
let Data ={
    "APIkey":APIkey,
    "Function":"et",
    "Type":"urlChecker",
    "FormatVersion" : FormatVersion ,
    "Value":"免費nitro?http://discord-gifft.com"
}

axios
        .post(APIhost, Data)
        .then(res => {
            if (res.data["state"] === "Success") {
                console.log(res.data)
                if (res.data["response"] === "All URL inspections passed") {
                    console.log("文本中沒有危險網址")
                }
                else if (res.data["response"] === "No URL found") {
                    console.log("文本中沒有網址")
                }
                else {
                    console.log("文本中含有危險網址")
                    msg.delete()
                }
            } else {
                console.log(`錯誤: ${res.data["response"]}`)
            }
        }).catch(err => {
            console.log(err)
        })
```

#### Python
```python
import requests

APIhost = "http://150.117.110.118:10150/"

APIkey = "放入你的 API Key"
FormatVersion = 1

Data ={
    "APIkey":APIkey,
    "Function":"et",
    "Type":"urlChecker",
    "FormatVersion" : FormatVersion ,
    "Value":"免費nitro?http://discord-gifft.com"
}

header = {"content-type": "application/json"}

response = requests.post(APIhost, json=Data, headers=header, verify=False)

Json = response.json()

if Json["state"] == "Success":
    if Json["response"] == "All URL inspections passed":
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
public static String Post(JsonObject Jsondata)  {
        String data = Jsondata.toString();
        URL url = null;
        try {
            url = new URL("http://150.117.110.118:10150/");
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        HttpURLConnection http = null;
        try {
            assert url != null;
            http = (HttpURLConnection)url.openConnection();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            assert http != null;
            http.setRequestMethod("POST");
        } catch (ProtocolException e) {
            e.printStackTrace();
        }
        http.setDoOutput(true);
        http.setConnectTimeout(5000);
        http.setRequestProperty("Authorization", "Bearer mt0dgHmLJMVQhvjpNXDyA83vA_PxH23Y");
        http.setRequestProperty("Content-Type", "application/json");
        byte[] out = data.getBytes(StandardCharsets.UTF_8);
        OutputStream stream = null;
        try {
            stream = http.getOutputStream();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            assert stream != null;
            stream.write(out);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String inputLine;
        StringBuilder response = new StringBuilder();
        try {
            if(http.getResponseCode() == 200){
                BufferedReader in = new BufferedReader(new InputStreamReader(http.getInputStream()));
                while ((inputLine = in .readLine()) != null) {
                    response.append(inputLine);
                } in .close();
            }else {
                System.out.println("API service did not respond");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        http.disconnect();
        JsonElement jsonElement = new JsonParser().parse(response.toString());
        JsonObject jsonObject = jsonElement.getAsJsonObject();
        if(Objects.equals(jsonObject.get("state").getAsString(), "Error")){
            System.out.println("There seems to be something wrong");
            System.out.println("[response] "+jsonObject.get("response").getAsString());
        }
        return response.toString();
    }
```

#### PHP
```PHP
$APIkey="放入你的 API Key";
$FormatVersion=1;

function post($Data){
$url = "http://150.117.110.118:10150/";    
$curl = curl_init($url);
$json=json_decode($Data,true);
$json["APIkey"]=$GLOBALS["APIkey"];
$json["FormatVersion"]=$GLOBALS["FormatVersion"];
$data=json_encode($json);
curl_setopt($curl, CURLOPT_HEADER, false);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_HTTPHEADER, array("Content-type: application/json"));
curl_setopt($curl, CURLOPT_POST, true);
curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
curl_close($curl);
return curl_exec($curl);
 }
```

## 功能
#### 功能列表
##### [et](#et)
- [urlChecker](#urlchecker)
- [md5](#md5)
##### [serverData](#serverData)
- [BlockValue](#BlockValue)
- [Inventory](#Inventory)
##### [economy](#economy)
- [assets](#assets)

# et
### urlChecker
- 加入版本: 21w52-pre1
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
- 加入版本: 22w04-pre1
- 說明: 用來獲取玩家方塊挖掘統計的功能
- FormatVersion: ```1```
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
- 說明: 用來獲取玩家背包物品詳情的功能
- FormatVersion: ```1```
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

# 貢獻者
* whes1015 - 程式開發
