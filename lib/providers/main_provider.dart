import 'dart:convert';
import 'dart:io';
import 'package:find_track/secret/secret.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;

class MainProvider with ChangeNotifier {
  final List<Map<dynamic, dynamic>> _listElements = [];

  Map _founded = {
    "image": "",
    "songName": "",
    "album": "",
    "artist": "",
    "relDate": "",
    "spotifyUrl": "",
    "appleUrl": "",
    "songLink": "",
  };

  bool _foundSong = false;
  bool _listen = false;
  bool _glow = false;
  String _str = "Toque para escuchar";

  bool get listen => _listen;
  String get str => _str;
  List get favs => _listElements;
  Map get found => _founded;
  bool get glow => _glow;
  bool get foundedSong => _foundSong;

//Método para cambiar el texto en la UI al escuchar
  void changeListen() {
    _listen = !_listen;
    print(listen);
    if (listen) {
      _str = "Escuchando...";
      notifyListeners();
    } else {
      _str = "Toque para escuchar";
      notifyListeners();
    }
    notifyListeners();
  }

//Cambia a true la repetición del glow en el botón principal.
  void startGlow() {
    _glow = !_glow;
    notifyListeners();
    print("glow = ${glow}");
  }

//Request HTTP
  Future<dynamic> getSong() async {
    final String endPoint = "https://api.audd.io/";
    final Duration recordDuration = Duration(seconds: 5);
    final record = Record();

    try {
      bool permit = await record.hasPermission();
      if (permit) {
        await record.start(encoder: AudioEncoder.aacLc);
        startGlow();
        changeListen();
        await Future.delayed(recordDuration);
        startGlow();
        changeListen(); //Esperar 4 segundos recomendados
        final path = await record.stop();
        if (path == null) return;

        String songCode = base64Encode(File(path).readAsBytesSync());
        final uri = Uri.parse(endPoint);
        var response = await http.post(uri, body: {
          "audio": songCode,
          "api_token": apiKey,
          "return": "spotify,apple_music,deezer"
        });
        if (response.statusCode == HttpStatus.ok) {
          print(jsonDecode(response.body));
          final body = jsonDecode(response.body);
          if (body["result"] != null) {
            //print("LLegue hasta aquí");
            _foundSong = true;
            notifyListeners();
            _founded["songName"] = body['result']['title'];
            _founded["artist"] = body["result"]["artist"];
            _founded["relDate"] = body["result"]["release_date"];
            _founded["songLink"] = body["result"]["song_link"];

            _founded["album"] = body["result"]["album"];
            _founded["image"] =
                body["result"]["spotify"]["album"]["images"][1]["url"];

            _founded["spotifyUrl"] =
                body["result"]["spotify"]["external_urls"]["spotify"];
            _founded["appleUrl"] = body["result"]["apple_music"]["url"];
          } else {
            _foundSong = false;
          }
          print(_founded);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  //Agregando a la lista de favoritos
  void pushToList() {
    final Map toAdd = {
      "image": _founded["image"],
      "songName": _founded["songName"],
      "artist": _founded["artist"]
    };
    _listElements.add(toAdd);
    notifyListeners();
  }

  void deleteFromList(index) {
    _listElements.removeAt(index);
    notifyListeners();
  }
}
