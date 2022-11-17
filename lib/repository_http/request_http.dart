import 'dart:convert';

import 'package:http/http.dart' as http;

import '../secret/secret.dart';

class HttpRequests {
  Future<dynamic> getSongBody(String songCode) async {
    final String endPoint = "https://api.audd.io/";
    final uri = Uri.parse(endPoint);
    try {
      var response = await http.post(uri, body: {
        "audio": songCode,
        "api_token": apiKey,
        "return": "spotify,apple_music,deezer"
      });
      if (response.statusCode == 200) {
        final _content = jsonDecode(response.body);
        return _content;
      } else
        return null;
    } catch (e) {
      print(e.toString());
    }
  }
}
