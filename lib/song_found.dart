import 'package:find_track/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SongFound extends StatelessWidget {
  SongFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Here you go"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        title: Text("Agregar a favoritos"),
                        content: Text(
                            "El elemento será agregado a favoritos. ¿Quieres continuar?"),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancelar",
                                style: TextStyle(color: Colors.purple),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.read<MainProvider>().pushToList();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Procesando...")));
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "La canción se ha agregado a favoritos")));
                              },
                              child: Text("Aceptar",
                                  style: TextStyle(color: Colors.purple)))
                        ],
                      );
                    }));

                //context.read<MainProvider>().pushToList();
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
              ))
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: EdgeInsets.all(1),
          child: Column(children: [
            Container(
              height: 400,
              child: Image.network(
                  "${context.read<MainProvider>().found["image"]}"),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    "${context.read<MainProvider>().found["songName"]}",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${context.read<MainProvider>().found["artist"]}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "${context.read<MainProvider>().found["album"]}",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    "${context.read<MainProvider>().found["relDate"]}",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Abrir con:",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    iconSize: 45,
                    onPressed: () {
                      final Uri _uri = Uri.parse(
                          "${context.read<MainProvider>().found["spotifyUrl"]}");
                      launchUrl(_uri);
                    },
                    icon: FaIcon(FontAwesomeIcons.spotify)),
                IconButton(
                    iconSize: 45,
                    onPressed: () {
                      final Uri _uri = Uri.parse(
                          "${context.read<MainProvider>().found["songLink"]}");
                      launchUrl(_uri);
                    },
                    icon: FaIcon(FontAwesomeIcons.barsStaggered)),
                IconButton(
                    iconSize: 45,
                    onPressed: () {
                      final Uri _uri = Uri.parse(
                          "${context.read<MainProvider>().found["appleUrl"]}");
                      launchUrl(_uri);
                    },
                    icon: FaIcon(FontAwesomeIcons.apple)),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
