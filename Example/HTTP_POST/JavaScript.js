const axios = require('axios')

let APIhost = "http://150.117.110.118:10150/"
let APIkey = "放入你的 API Key"
let FormatVersion = 1
let Data ={
    "APIkey":APIkey,
    "Function":"et",
    "Type":"urlChecker",
    "FormatVersion" : FormatVersion ,
    "Value":"免費nitro?http://discord-gifft.com"
}

axios
        .post(APIhost, Data)
        .then(res => {
            if (res.data["state"] === "Success") {
                console.log(res.data)
                if (res.data["response"] === "All URL inspections passed") {
                    console.log("文本中沒有危險網址")
                }
                else if (res.data["response"] === "No URL found") {
                    console.log("文本中沒有網址")
                }
                else {
                    console.log("文本中含有危險網址")
                    msg.delete()
                }
            } else {
                console.log(`錯誤: ${res.data["response"]}`)
            }
        }).catch(err => {
            console.log(err)
        })
