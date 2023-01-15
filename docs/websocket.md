# API 文檔

### Base URL
```
wss://exptech.com.tw/api
```

### Body
```json5
{
  uuid     : UUID, // 用於識別不同設備
  function : "subscriptionService",
  value    : ["earthquake-v3", "rts-v2"], // 接收的服務
  key      : {key}, // 權限驗證
}
```
- 可以在 [這裡](https://exptech.com.tw/api/v1/et/uuid) 獲取一組 UUID
- UUID 只需在第一次連接至伺服器時生成 後續可一直使用同一個 UUID
- key 用於驗證特殊服務接收權限

### 服務
#### PWS
`pws-v1`
```json5
{
    "type": "pws",
    "format": 1,
    "timestamp": 1673424017605,
    "raw": {
        "id": "20230111-PWS_MESSAGE_CASE1_000000001",
        "title": "系統測試",
        "sent": "2023-01-11CST16:00:02+08:00:00",
        "expires": "2023-01-11CST16:05:00+08:00:00",
        "sender": {
            "value": "災防告警細胞廣播訊息系統營運辦公室"
        },
        "status": "Actual",
        "msgType": "Alert",
        "eventCode": {
            "value": "systemTest"
        },
        "area": {
            "areaDesc": "Test_Geocode",
            "geocode": [
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "10002"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "10004"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "10005"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "10007"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "10008"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "10009"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "10010"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "10013"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "10014"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "10015"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "10016"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "10017"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "10018"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "10020"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "63"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "64"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "65"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "66"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "67"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "68"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "09007"
                },
                {
                    "valueName": "Taiwan_Geocode_103",
                    "value": "09020"
                }
            ]
        },
        "channel": {
            "value": "4380"
        },
        "link": {
            "rel": "alternate",
            "href": "https://cbs.tw/23013ca3bb1e"
        },
        "description": {
            "type": "html",
            "$t": "﹝災防告警訊息測試﹞每月訊息發送測試，敬請見諒，電信業者共同關心您。Public Warning System is testing, please don&#8217;t panic."
        }
    }
}
```
