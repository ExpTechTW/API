# 索引
- [注意](#注意)
- [規則列表](#規則列表)

## 注意
- `https://github.com/ExpTechTW` 為 公共密鑰 非全部功能皆可使用

## 規則列表
#### [et](#et)
- [urlChecker](#urlchecker) | 網址安全檢查 ( Google提供服務 )
- [md5](#md5) | MD5 加密
#### [data](#data)
- [radar](#radar) | 雷達迴波
- [satellite](#satellite) | 衛星雲圖
- [accumulation](#accumulation) | 累積雨量
- [PrecipitationForecast](#PrecipitationForecast) | 降水預報
- [earthquake](#earthquake) | 近 50 筆 地震報告 [小區域/編號]
- [TREM](#TREM) | TREM 即時測站 & IRIS 測站 三向加速度資料
- [report](#report) | 查詢編號地震詳細資料 (中央氣象局地震速報訊息)
- [EEW-v1](#EEW-v1) | 強震即時警報 ( 最新一報 )


# et
### urlChecker
- 傳輸協定: `POST (HTTP)`
- [FormatVersion](https://github.com/ExpTechTW/API/blob/%E4%B8%BB%E8%A6%81%E7%9A%84-(main)/FORMAT.md): `2`  `1`
- 範例: 
```json5
{
  "APIkey": "https://github.com/ExpTechTW",
  "Function": "et",
  "Type": "urlChecker",
  "Value": "<欲檢測文本>"
}
```

### md5
- 傳輸協定: `POST (HTTP)`
- 範例: 
```json5
{
  "APIkey": "https://github.com/ExpTechTW",
  "Function": "et",
  "Type": "md5",
  "Value": "<欲 md5 文本>"
}
```


# data
### earthquake
- 傳輸協定: `POST (HTTP)`
- 範例: 
```json5
{
  "APIkey": "https://github.com/ExpTechTW",
  "Function": "data",
  "Type": "earthquake",
  "Value":50 // 最多 50 數量越多越慢
}
```

### radar
- 傳輸協定: `POST (HTTP)`
- 注意: Response 須加上 `https://exptech.com.tw/get?Function=File&Path=`
- 範例: 
```json5
{
  "APIkey": "https://github.com/ExpTechTW",
  "Function": "data",
  "Type": "radar"
}
```

### satellite
- 傳輸協定: `POST (HTTP)`
- 注意: Response 須加上 `https://exptech.com.tw/get?Function=File&Path=`
- 範例: 
```json5
{
  "APIkey": "https://github.com/ExpTechTW",
  "Function": "data",
  "Type": "satellite"
}
```

### accumulation
- 傳輸協定: `POST (HTTP)`
- 注意: Response 須加上 `https://exptech.com.tw/get?Function=File&Path=`
- 範例: 
```json5
{
  "APIkey": "https://github.com/ExpTechTW",
  "Function": "data",
  "Type": "accumulation"
}
```

### PrecipitationForecast
- 傳輸協定: `POST (HTTP)`
- 注意: Response 須加上 `https://exptech.com.tw/get?Function=File&Path=`
- 範例: 
```json5
{
  "APIkey": "https://github.com/ExpTechTW",
  "Function": "data",
  "Type": "PrecipitationForecast"
}
```

### TREM
- 傳輸協定: `POST (HTTP)`
- 範例: 
```json5
{
  "APIkey": "https://github.com/ExpTechTW",
  "Function": "data",
  "Type": "TREM",
  "Value":0 // 0=即時資料 使用特定時間的 Unix(ms) 時間 可抓取特定時間資料
}
```

### report
- 傳輸協定: `POST (HTTP)`
- 範例: 
```json5
{
  "APIkey": "https://github.com/ExpTechTW",
  "Function": "data",
  "Type": "report",
  "Value":"<地震編號>"
}
```

### EEW-v1
- 傳輸協定: `POST (HTTP)`
- 注意: 需要使用經過申請的 APIkey
- 範例: 
```json5
{
  "APIkey": "https://github.com/ExpTechTW",
  "Function": "data",
  "Type": "EEW-v1",
  // "Value":"earthquake" 指定發報單位
  // • 日本氣象廳 JMA_earthquake
  // • 韓國氣象廳 KMA_earthquake
  // • 防災科研 NIED_earthquake
  // • 交通部中央氣象局 earthquake 
  // • 福建省地震局 FJDZJ_earthquake
  // • 成都高新減災研究所 ICL_earthquake
}
```
