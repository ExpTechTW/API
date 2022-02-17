#include <HTTPClient.h>
#include <ArduinoJson.h>
#include <WiFiClient.h>

HTTPClient http;
WiFiClient client;
http.begin(client, "http://150.117.110.118:10150/");
http.setConnectTimeout(1000);
http.addHeader("Content-Type", "application/json");

json["ver"] =  ver;
json["Function"]   = "service";

char json_string[4096];
serializeJson(json, json_string);
int httpResponseCode = http.POST(json_string);
Serial.println(http.getString());
http.end();
