# 地震報告

## 獲取地震報告

獲取所有地震報告

**網址** : `/earthquake/reports`

**方法** : `GET`

**參數**

|   key  	|      種類      	|         敘述         	| 預設值 	|
|:------:	|:--------------:	|:--------------------:	|:------:	|
| limit? 	| 整數 `integer` 	| 要回傳的地震報告數量 	| `15`   	|

### 成功回覆

**狀態瑪** : `200 OK`

**回覆範例**

```json
[
  {
    "identifier": "CWB-EQ111000-2022-1009-001513",
    "earthquakeNo": 111000,
    "epicenterLon": 121.03,
    "epicenterLat": 22.71,
    "location": "臺東縣政府西南西方  13.7  公里 (位於臺東縣臺東市)",
    "depth": 6.8,
    "magnitudeValue": 3.6,
    "originTime": "2022-10-09 00:15:13",
    "data": [
      {
        "areaName": "屏東縣",
        "areaIntensity": 2,
        "eqStation": [
          {
            "stationName": "三地門",
            "stationLon": 120.64,
            "stationLat": 22.74,
            "distance": 39.7,
            "stationIntensity": 2
          }
        ]
      }
    ],
    "ID": [ ]
  }
]
```

### 錯誤回覆

**狀態瑪** : `404 Not Found`

-----

## 獲取編號地震詳細資訊

獲取有編號的地震詳細資訊

**網址** : `/earthquake/reports/:id`

**方法** : `GET`

### 成功回覆

**狀態瑪** : `200 OK`

**回覆範例**

```json
{
  "Function": "report",
  "Time": 1656682329000,
  "EastLongitude": "121.42",
  "NorthLatitude": "22.17",
  "Depth": "21.4",
  "Scale": "4.8",
  "UTC+8": "2022-07-01 21:32:09",
  "Location": "臺東縣政府南南東方  69.9  公里 (位於臺灣東南部海域)",
  "Max": "4",
  "EventImage": "https://scweb.cwb.gov.tw/webdata/OLDEQ/202207/2022070121320948076_H.png",
  "ShakeImage": "https://scweb.cwb.gov.tw/webdata/drawTrace/plotContour/2022/2022076i.png",
  "Web": "https://scweb.cwb.gov.tw/zh-tw/earthquake/details/2022070121320948076",
  "No": "111076",
  "TimeStamp": 1656693297705,
  "Intensity": [
    {
      "areaDesc": "臺東縣地區",
      "areaMaxIntensity": {
        "unit": "級",
        "$t": "4"
      },
      "station": [
        {
          "stationName": "蘭嶼",
          "stationCode": "LAY",
          "stationLon": {
            "unit": "度",
            "$t": "121.56"
          },
          "stationLat": {
            "unit": "度",
            "$t": "22.04"
          },
          "distance": {
            "unit": "公里",
            "$t": "21.02"
          },
          "azimuth": {
            "unit": "度",
            "$t": "316.17"
          },
          "stationIntensity": {
            "unit": "級",
            "$t": "4"
          },
          "pga": {
            "unit": "gal",
            "vComponent": "18.90",
            "nsComponent": "42.27",
            "ewComponent": "52.56"
          },
          "waveImageURI": "https://scweb.cwb.gov.tw/webdata/drawTrace/outcome/2022/2022076/4-LAY.gif"
        }
      ]
    }
  ]
}
```

### 錯誤回覆

**狀態瑪** : `404 Not Found`