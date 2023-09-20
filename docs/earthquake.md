# Earthquake
## Earthquake List (v1)
#### 介紹
- 回傳地震列表 提供 震度 規模 深度 發震時間 等 資訊
#### URL
- `GET https://api.exptech.com.tw/api/v1/earthquake`
#### 查詢參數
- 無
#### 權限
- 無
#### 回傳內容
```json
[
    {
        "identifier": "CWA-EQ112000-2023-0920-224526",
        "earthquakeNo": 112000,
        "epicenterLon": 121.43,
        "epicenterLat": 23.22,
        "location": "臺東縣政府北北東方  58.2  公里 (位於臺東縣近海)",
        "depth": 35.8,
        "magnitudeValue": 4.1,
        "originTime": "2023/09/20 22:45:26",
        "data": [
            {
                "areaName": "臺東縣",
                "areaIntensity": 2,
                "eqStation": [
                    {
                        "stationName": "長濱",
                        "stationLon": 121.45,
                        "stationLat": 23.32,
                        "distance": 11.5,
                        "stationIntensity": 2
                    }
                ]
            }
        ],
        "ID": [],
        "trem": [
            "888"
        ],
        "timestamp": 1695221911071
    }
]
```
| 名稱 | 說明 |
| ----------- | ----------- |
| identifier | 地震 ID |
| earthquakeNo | 地震編號 `末三碼 000 為 小區域有感地震` |

## Earthquake Event (v1)
