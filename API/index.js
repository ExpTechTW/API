//#region 依賴
const express = require('express');
const fs = require('fs');
const translate = require('@vitalets/google-translate-api');
const app = express();
const fetch = require('node-fetch');
//#endregion

//#region 變數
let ver = "21w42"
let API_json
let URL_json
let check = ""
const port = 1015;
let safe = ""
//#endregion

//#region 解碼
app.use(express.urlencoded({
    extended: false
}))
//#endregion

//#region 處理區域
app.post('/', (req, res) => {
    fs.readFile('./Json/API.json', function (error, data) {
        if (error) {
            console.log('\x1b[31m', "檔案讀取失敗", '\x1b[0m')
            res.send({ "response": "API-Error: 0001", "ver": ver })
        } else {
            API_json = JSON.parse(data.toString());
            if (req.body.API == undefined) {
                res.send({ "response": "API-Error: 0002", "ver": ver })
            } else {
                check = ""
                for (let x = 0; x < API_json["Data_Quantity"]; x++) {
                    if (API_json["Data"][x]["API"] == req.body.API) {
                        check = "1"
                        break
                    }
                }
                if (check == "") {
                    res.send({ "response": "API-Error: 0003", "ver": ver })
                } else {
                    if (req.body.function == undefined) {
                        res.send({ "response": "API-Error: 0004", "ver": ver })
                    } else {
                        if (req.body.function == "translation-en") {
                            translate(req.body.value, { to: 'en' }).then(Tres => {
                                res.send({ "response": Tres.text, "ver": ver })
                            }).catch(err => {
                                res.send({ "response": "API-Error: 0005", "ver": ver })
                            });
                        } else if (req.body.function == "translation-TW") {
                            translate(req.body.value, { to: 'zh-TW' }).then(Tres => {
                                res.send({ "response": Tres.text, "ver": ver })
                            }).catch(err => {
                                res.send({ "response": "API-Error: 0005", "ver": ver })
                            });
                        } else if (req.body.function == "URL_Security_Verification") {
                            try {
                                fs.readFile('./Json/URL.json', function (error, data) {
                                    URL_json = JSON.parse(data.toString());
                                    safe = ""
                                    let messageURL = req.body.value
                                    for (let x = 0; x < URL_json["Data_Quantity"]; x++) {
                                        if (messageURL.includes(URL_json["Data"][x]["URL"]) == true) {
                                            safe = "1"
                                            res.send({ "report": "URL", "Type": URL_json["Data"][x]["Type"], "ver": ver })
                                            break
                                        }
                                    }
                                    if (safe == "") {
                                        res.send({ "response": "Safety", "ver": ver })
                                    }
                                })
                            } catch (error) {
                                res.send({ "response": "API-Error: 0006", "ver": ver })
                            }
                        } else if (req.body.function == "Discord-Bot-Public_latest") {
                            fetch('https://api.github.com/repos/ExpTechTW/Discord-Bot-Public/releases')
                                .then(function (res) {
                                    return res.json();
                                }).then(function (json) {
                                    res.send(json[0])
                                })
                        } 
                    }
                }
            }
        }
    })
})
//#endregion

app.listen(port, () => console.log(`API 已啟動!`));