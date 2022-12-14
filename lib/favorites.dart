import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_track/widgets/songs_list.dart';
import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  final Stream<QuerySnapshot> songs =
      FirebaseFirestore.instance.collection('favorites').snapshots();

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
                  child: StreamBuilder<QuerySnapshot>(
                    stream: songs,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final data = snapshot.requireData;

                      return ListView.builder(
                        itemCount: data.size,
                        itemBuilder: (BuildContext context, int index) {
                          return SongsList(
                              songs: data.docs[index], indice: index);
                        },
                      );
                    },
                  ))
            ],
          ),
        ));
  }
}
