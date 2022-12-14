import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_track/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SongsList extends StatefulWidget {
  final Function? function;
  final QueryDocumentSnapshot songs;
  final indice;

  SongsList(
      {super.key, this.function, required this.songs, required this.indice});

  @override
  State<SongsList> createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      height: 325,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: Text("Redirigiendo..."),
                          content:
                              Text("Serás redirigido. ¿Quieres continuar?"),
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
                                  final Uri _uri = Uri.parse(
                                      "${context.read<MainProvider>().found["songLink"]}");
                                  launchUrl(_uri);
                                },
                                child: Text("Aceptar",
                                    style: TextStyle(color: Colors.purple)))
                          ],
                        );
                      }));
                },
                child: Image.network(
                  "${widget.songs["image"]}",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 50,
                  color: Colors.blue,
                  child: Column(
                    children: [
                      Text(
                        "${widget.songs["songName"]}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text("${widget.songs["artist"]}"),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              child: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: Text("Remover de favoritos"),
                          content: Text(
                              "El elemento será eliminado de tus favoritos. ¿Quieres continuar?"),
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
                                  deleteSong(widget.songs);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Procesando...")));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "La canción se ha eliminado de favoritos")));
                                },
                                child: Text("Aceptar",
                                    style: TextStyle(color: Colors.purple)))
                          ],
                        );
                      }));
                },
                icon: Icon(Icons.favorite),
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }

  deleteSong(QueryDocumentSnapshot songs) async {
    await FirebaseFirestore.instance
        .collection('favorites')
        .where('songName', isEqualTo: songs['songName'])
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                FirebaseFirestore.instance
                    .collection('favorites')
                    .doc(element.id)
                    .delete();
              })
            });
  }
}
