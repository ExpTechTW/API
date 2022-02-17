import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> NetWork(String json) async {
  try {
    Map<String, dynamic> Json = jsonDecode(json);
    if (Json["Function"] == null) {
      Json["Function"] = "answer";
    }
    var response = await http
        .post(Uri.parse("http://150.117.110.118:10150/"),
            headers: {"content-type": "application/json"},
            body: utf8.encode(jsonEncode(Json)))
        .timeout(Duration(seconds: 5));
    String reply = response.body;
    var Data = jsonDecode(reply);
    return Data;
  } on SocketException catch (e) {
    String msg = e.message;
    return jsonDecode(
        '{"state":"Error","service":{"state":"Error"},"response":"$msg"}');
  }
}
