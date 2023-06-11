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
報錯
- `Invaild name!` 用戶名稱無效(大於30字、含有空格)
- `Invaild email!` 電子郵件無效(大於350字)
- `Name format error!` 用戶名稱不合法(合法字 => ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890@-_.)
- `This name already in use!` 用戶名稱已被使用
- `This email already in use!` 電子郵件已被使用

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
報錯
- `Invaild name!` 用戶名稱無效(大於30字、含有空格)
- `Verify error!` 驗證碼錯誤
- `Name format error!` 用戶名稱不合法(合法字 => ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890@-_.)
- `Invaild pass!` 用戶密碼無效(大於30字、小於6字、含有空格)
- `Pass format error!` 用戶密碼不合法(合法字 => ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890@-_.)

## 忘記密碼
- 使用電子郵件接收驗證碼
#### URL
POST `https://exptech.com.tw/api/v1/et/forget-email`
#### Body
```json5
{
    "email":"expTech.tw@gmail.com" // 電子郵件
}
```
報錯
- `Invaild email!` 電子郵件無效(大於350字)
- `Can't find account from this email!` 未發現使用此電子郵件的帳戶

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
報錯
- `Invaild name!` 用戶名稱無效(大於30字、含有空格)
- `Verify error!` 驗證碼錯誤
- `Invaild pass!` 用戶密碼無效(大於30字、小於6字、含有空格)

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
報錯
- `Invaild name(old)!` 舊用戶名稱無效(大於30字、含有空格)
- `Invaild pass(old)!` 舊用戶密碼無效(大於30字、含有空格)
- `No changes found!` 未發現資料變更
- `Invaild name(new)!` 新用戶名稱無效(大於30字、含有空格)
- `Invaild pass(new)!` 新用戶密碼無效(大於30字、含有空格)
- `Name(new) format error!` 新用戶帳戶不合法(合法字 => ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890@-_.)
- `Pass(new) format error!` 新用戶密碼不合法(合法字 => ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890@-_.)
- `This name already in use!` 新名稱已被使用
- `Can't find account from this Name(old) and Pass(old)!` 無法從 舊名稱 及 舊密碼 找到相關帳戶

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
```
報錯
- `Can't find this account!` 未發現此帳戶

## 查詢剩餘請求次數
- 查詢剩餘請求次數
####
GET `https://exptech.com.tw/api/v1/et/balance?key=${key}`

### 注意
- 用戶名稱不得 `大於 30字元`
- 密碼不得 `小於 6字元` 或 `大於 30字元`
- 用戶名稱及密碼不得包含空格
