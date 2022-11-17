import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:find_track/song_found.dart';
import 'package:flutter/material.dart';
import 'package:find_track/favorites.dart';
import 'package:find_track/providers/main_provider.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                "${context.watch<MainProvider>().str}",
                style: TextStyle(color: Colors.white, fontSize: 21),
              ),
              SizedBox(
                height: 30,
              ),
              AvatarGlow(
                glowColor: Colors.purple,
                endRadius: 200,
                duration: Duration(milliseconds: 2000),
                animate: context.watch<MainProvider>().glow,
                repeat: true, //
                showTwoGlows: true,
                repeatPauseDuration: Duration(milliseconds: 100),
                child: SizedBox(
                  height: 220,
                  width: 220,
                  child: FloatingActionButton(
                    heroTag: "record",
                    backgroundColor: Colors.white,
                    onPressed: () {
                      context.read<MainProvider>().getSong();
                      Timer(const Duration(seconds: 7), () async {
                        if (context.read<MainProvider>().foundedSong == true)
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => SongFound())));
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("No se encontró la canción")));
                        }
                      });
                    },
                    child: Image.asset(
                      "assets/music.png",
                      height: 200,
                    ),
                  ),
                ),
              ),
              FloatingActionButton(
                heroTag: "favorites",
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => Favorites())));
                },
                child: Icon(Icons.favorite),
              ),
              SizedBox(
                height: 35,
              ),
              SignOutButton()
            ],
          ),
        ),
      ),
    );
  }
}
