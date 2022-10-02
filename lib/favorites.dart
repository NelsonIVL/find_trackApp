import 'package:find_track/providers/main_provider.dart';
import 'package:find_track/widgets/songs_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Canciones favoritas")),
        body: Container(
          child: Column(
            children: [
              Container(
                height: 650,
                child: ListView.builder(
                  itemCount: context.read<MainProvider>().favs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SongsList(
                        indice: index,
                        songs: context.read<MainProvider>().favs[index]);
                  },
                ),
              )
            ],
          ),
        ));
  }
}
