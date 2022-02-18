##  規則列表

#### [et](#et) `POST (HTTP)`

- [urlChecker](#urlchecker) `POST (HTTP)`

- [md5](#md5) `POST (HTTP)`

#### [serverData](#serverData) `POST (HTTP)`

- [BlockValue](#BlockValue) `POST (HTTP)`

- [Inventory](#Inventory) `POST (HTTP)`

- [Statistic](#Statistic) `POST (HTTP)`

#### [economy](#economy) `POST (HTTP)`

- [assets](#assets) `POST (HTTP)`

# et

### urlChecker

- 加入版本: 21w52-pre1

- 傳輸協定: `POST (HTTP)`

- 說明: 用來檢測惡意網址的功能

- FormatVersion: `2`  `1`

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
