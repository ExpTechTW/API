/* eslint-disable prefer-const */
const WebSocket = require("ws");
const axios = require("axios");
const fetch = require("node-fetch");

let ws;
let Reconnect = false;
let ServerT = 0;
let ServerTime = 0;
let NOW = new Date();

let IP = {
	"HTTP"      : [],
	"WEBSOCKET" : [],
};
let LifeTime = {};

let Pdata = {
	"APIkey"   : "https://github.com/ExpTechTW",
	"Function" : "proxy",
};

Main();

function Main() {
	fetch("https://raw.githubusercontent.com/ExpTechTW/API/master/IP.json")
		.then((response) => response.json())
		.then((res) => {
			let url = res.Proxy[Object.keys(res.Proxy)[Math.floor((Math.random() * Object.keys(res.Proxy).length))]];
			axios.post(url, Pdata)
				.then((response) => {
					let data = response.data.response.online;
					for (let index = 0; index < Object.keys(data.HTTP).length; index++) {
						LifeTime[`http://${Object.keys(data.HTTP)[index]}/`] = data.HTTP[Object.keys(data.HTTP)[index]];
						IP.HTTP.push(`http://${Object.keys(data.HTTP)[index]}/`);
						console.log(`http://${Object.keys(data.HTTP)[index]}/`);
					}
					for (let index = 0; index < Object.keys(data.WEBSOCKET).length; index++) {
						LifeTime[`ws://${Object.keys(data.WEBSOCKET)[index]}/`] = data.WEBSOCKET[Object.keys(data.WEBSOCKET)[index]];
						IP.WEBSOCKET.push(`ws://${Object.keys(data.WEBSOCKET)[index]}/`);
					}
					for (let index = 0; index < Object.keys(data.SSL).length; index++) {
						LifeTime[`https://${Object.keys(data.SSL)[index]}/`] = data.SSL[Object.keys(data.SSL)[index]];
						LifeTime[`wss://${Object.keys(data.SSL)[index]}/`] = data.SSL[Object.keys(data.SSL)[index]];
						IP.HTTP.push(`https://${Object.keys(data.SSL)[index]}/`);
						IP.WEBSOCKET.push(`wss://${Object.keys(data.SSL)[index]}/`);
					}
					TimeNow(response.data.response.Full);
				}).catch((err) => {
					Main();
				});
		});
}

function PostIP() {
	if (IP.HTTP.length == 0) return "https://exptech.mywire.org:1015/";
	let url = IP.HTTP[Math.floor((Math.random() * IP.HTTP.length))];
	if (NOW.getTime() - LifeTime[url] > 30000) {
		IP.HTTP.splice(IP.HTTP.indexOf(url), 1);
		return "https://exptech.mywire.org:1015/";
	}
	return url;
}

function WebsocketIP() {
	if (IP.WEBSOCKET.length == 0) return "wss://exptech.mywire.org:1015/";
	let url = IP.WEBSOCKET[Math.floor((Math.random() * IP.WEBSOCKET.length))];
	if (NOW.getTime() - LifeTime[url] > 30000) {
		IP.WEBSOCKET.splice(IP.WEBSOCKET.indexOf(url), 1);
		return "wss://exptech.mywire.org:1015/";
	}
	return url;
}

// #region Websocket
function reconnect() {
	if (Reconnect) return;
	Reconnect = true;
	setTimeout(() => {
		createWebSocket();
		Reconnect = false;
	}, 2000);
}

function createWebSocket() {
	try {
		ws = new WebSocket("wss://exptech.mywire.org:1015", { handshakeTimeout: 3000 });
		initEventHandle();
	} catch (e) {
		reconnect();
	}
}

function initEventHandle() {
	ws.onclose = function() {
		reconnect();
	};

	ws.onerror = function(err) {
		reconnect();
	};

	ws.onopen = function() {
		ws.send(JSON.stringify({
			"APIkey"        : "https://github.com/ExpTechTW",
			"Function"      : "earthquakeService",
			"Type"          : "subscription-v1",
			"FormatVersion" : 3,
			"UUID"          : localStorage.UUID,
		}));
		dump({ level: 0, message: `Connected to API Server (${localStorage.UUID})`, origin: "WebSocket" });
	};

	ws.onmessage = function(evt) {
		let json = JSON.parse(evt.data);
		dump({ level: 3, message: `(onMessage) Received ${json.Function ?? json.response}`, origin: "WebSocket" });
		if (json.Function == "NTP") {
			IP = {
				"HTTP"      : [],
				"WEBSOCKET" : [],
			};
			let data = json.online;
			for (let index = 0; index < Object.keys(data.HTTP).length; index++) {
				LifeTime[`http://${Object.keys(data.HTTP)[index]}/`] = data.HTTP[Object.keys(data.HTTP)[index]];
				IP.HTTP.push(`http://${Object.keys(data.HTTP)[index]}/`);
			}
			for (let index = 0; index < Object.keys(data.WEBSOCKET).length; index++) {
				LifeTime[`ws://${Object.keys(data.WEBSOCKET)[index]}/`] = data.WEBSOCKET[Object.keys(data.WEBSOCKET)[index]];
				IP.WEBSOCKET.push(`ws://${Object.keys(data.WEBSOCKET)[index]}/`);
			}
			for (let index = 0; index < Object.keys(data.SSL).length; index++) {
				LifeTime[`https://${Object.keys(data.SSL)[index]}/`] = data.SSL[Object.keys(data.SSL)[index]];
				LifeTime[`wss://${Object.keys(data.SSL)[index]}/`] = data.SSL[Object.keys(data.SSL)[index]];
				IP.HTTP.push(`https://${Object.keys(data.SSL)[index]}/`);
				IP.WEBSOCKET.push(`wss://${Object.keys(data.SSL)[index]}/`);
			}
			TimeNow(json.Full);
		}
	};
}

function TimeNow(now) {
	ServerT = new Date().getTime();
	ServerTime = now;
}

setInterval(() => {
	NOW = new Date(ServerTime + (new Date().getTime() - ServerT));
}, 0);
// #endregion
