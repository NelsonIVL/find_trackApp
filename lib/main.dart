import 'package:find_track/login/login_page.dart';
import 'package:find_track/providers/main_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:find_track/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<MainProvider>(create: ((context) => MainProvider())),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FindTrackApp',
      theme:
          ThemeData(primarySwatch: Colors.purple, brightness: Brightness.light),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(brightness: Brightness.dark),
      home:
          FirebaseAuth.instance.currentUser == null ? LoginPage() : HomePage(),
    );
  }
}
