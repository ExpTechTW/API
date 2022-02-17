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
