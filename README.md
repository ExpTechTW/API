# ExpTech 探索科技 GitHub
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

## 項目概要
* 這是由 ExpTech 開發，涵蓋各種功能及平台的強大 API

## 使用條件
* 協議: POST
* URL 主服務器: http://exptech.mywire.org:1015/
* URL 次服務器: http://exptech.mywire.org:910/
* POST Body: API=[Put Your API Key Here]&&function=[Put Function ID]&&value=[Put Value Here]

## 可用功能 - Function ID | 說明
* Nothing | 只使用 API=[Put Your API Key Here] 不添加其他任何參數，可以測試連線
* translation-en | value 參數放入的文字，將會被轉換成英文，然後返回值
* translation-TW | value 參數放入的文字，將會被轉換成中文，然後返回值

## 貢獻者
* whes1015 - 程式開發
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
* 這是一個由 ExpTech.tw 開發的 Discord 機器人
* [邀請鏈接]( https://reurl.cc/Xloo6D)
* 官方 [Discord](https://discord.gg/rkPu3msUf3)

# 索引
- [開始](#開始)
  - [註冊服務](#註冊服務)
- [權限](#權限)
- [指令](#指令)
  - [指令列表](#指令列表)
- [貢獻者](#貢獻者)

# 文檔
## 開始
#### 註冊服務
* 1.邀請 Discord 機器人
* 2.使用 /et register 申請服務
* 3.使用 /et set apikey [你的 API Key] 來註冊服務

## 權限
- 4 - owner - 擁有者
- 3 - admin - 管理員
- 2 - helper - 幫手
- 1 - user - 普通用戶 (默認)
- 0 - guest - 訪客或熊孩子 (禁用所有指令)

## 指令
#### 指令列表
##### [/et](#et)
- [register](#register)
- [set](#set)
  - [apikey](#apikey)
  - [urlchecker](#urlchecker)
##### [/mc](#mc)
- [je](#je)
  - [certified](#certified)
- [be](#be)
  - [certified](#certified)

# /et
## register 
- 完整指令: ```/et register```
- 加入版本: 21w52-pre1
- 權限: ≥ 4
- 默認: ```null```
- 選項: ```null```
- 說明: 每個伺服器可以申請一個 API Key 用來註冊 ExpTech_Discord_Bot 的服務
，或是用來自製機器人，每個 API Key 的每日請求限制為 50000 次。

## set
#### apikey
- 完整指令: ```/et set apikey [你的 API Key]```
- 加入版本: 21w52-pre1
- 權限: ≥ 4
- 默認: ```null```
- 選項: ```String```
- 說明: 用來向 ExpTech_Discord_Bot 註冊服務

#### urlchecker
- 完整指令: ```/et set urlchecker [選項]```
- 加入版本: 21w52-pre1
- 權限: ≥ 3
- 默認: ```false```
- 選項: ```false``` ```true```
- 說明: 用來檢測惡意網址的功能

# /mc
## je
#### certified
- 完整指令: ```/mc je certified [玩家代號]```
- 加入版本: 21w52-pre1
- 權限: ≥ 1
- 默認: ```null```
- 選項: ```String```
- 說明: Minecraft Java Edition 帳號認證

## be
#### certified
- 完整指令: ```/mc be certified [玩家代號]```
- 加入版本: 21w52-pre1
- 權限: ≥ 1
- 默認: ```null```
- 選項: ```String```
- 說明: Minecraft Bedrock Edition 帳號認證

# 貢獻者
* whes1015 - 程式開發
