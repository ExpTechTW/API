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
  value    : ["trem-rts-v2","eew-v1"], // 接收的服務
  key      : {key}, // 權限驗證
}
```
- 可以在 [這裡](https://exptech.com.tw/api/v1/et/uuid) 獲取一組 UUID
- UUID 只需在第一次連接至伺服器時生成 後續可一直使用同一個 UUID
- key 用於驗證特殊服務接收權限

### 服務
- `trem-eq-v1` TREM 地震檢知
- `pws-v1` PWS 訊息
- `eew-v1` EEW 訊息 (JMA、KMA、NIED、SCDZJ、FJDZJ)
- `trem-rts-v1` `trem-rts-v2` TREM 即時測站
- `report-v1` 地震報告
- `tsunami-v1` 海嘯警報 (警報、資訊)
- `intensity-v1` 鄉鎮震度速報
- `trem-image-v1` TREM Image
- `palert` P-Alert 近即時震度
- `trem-rts-original-v1` 即時 Z軸 波形資料
- `trem-rts-image-v1` rts image 圖像
