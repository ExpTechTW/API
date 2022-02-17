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
`POST (HTTP)`
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
`POST (HTTP)`
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
`POST (HTTP)`
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
`POST (HTTP)`
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
