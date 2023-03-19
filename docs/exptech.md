## 綁定電子郵件
- 將名稱和電子郵件綁定 (檢查名稱及電子郵件是否已使用)
#### URL
POST `https://exptech.com.tw/api/v1/et/sign-up-email`
#### Body
```json5
{
    "name":"ExpTechTW", // 名稱
    "email":"expTech.tw@gmail.com" // 電子郵件
}
```

## 註冊
- 使用名稱和電子郵件註冊帳號
#### URL
POST `https://exptech.com.tw/api/v1/et/sign-up`
#### Body
```json5
{
    "name":"ExpTechTW", // 名稱
    "pass":"1234567890", // 密碼
    "code":"13AD45" // 驗證碼 (發到電子郵件)
}
```

## 忘記密碼
- 使用電子郵件接收驗證碼
#### URL
POST `https://exptech.com.tw/api/v1/et/forget-email`
#### Body
```json5
{
    "name":"ExpTechTW", // 名稱
    "email":"expTech.tw@gmail.com" // 電子郵件
}
```

## 重設密碼
- 使用驗證碼重設密碼
#### URL
POST `https://exptech.com.tw/api/v1/et/forget`
#### Body
```json5
{
    "name":"ExpTechTW", // 名稱
    "pass":"1234567890", // 密碼
    "code":"13AD45" // 驗證碼 (發到電子郵件)
}
```

## 重設帳戶資訊
- 使用驗證碼重設密碼
#### URL
POST `https://exptech.com.tw/api/v1/et/edit`
#### Body
```json5
{
    "old_name":"ExpTechTW", // 舊名稱
    "old_pass":"1234567890", // 舊密碼
    "new_name":"NEW_ExpTechTW", // 新名稱
    "new_pass":"0987654321", // 新密碼
}
```

## 登入
- 使用帳號密碼登入
#### URL
POST `https://exptech.com.tw/api/v1/et/sign-in`
#### Body
```json5
{
    "name":"ExpTechTW", // 名稱
    "pass":"1234567890", // 密碼
}

### 注意
- 用戶名稱不得 `大於 30字元`
- 密碼不得 `小於 6字元` 或 `大於 30字元`
- 用戶名稱及密碼不得包含空格
