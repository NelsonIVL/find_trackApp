import 'package:find_track/auth/bloc/auth_bloc.dart';
import 'package:find_track/login/login_page.dart';
import 'package:find_track/login/login_page2.dart';
import 'package:find_track/providers/main_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:find_track/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(VerifyAuthEvent())),
      ],
      child: ChangeNotifierProvider(
        create: (context) => MainProvider(),
        child: MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FindTrackApp',
        theme: ThemeData(
            primarySwatch: Colors.purple, brightness: Brightness.light),
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(brightness: Brightness.dark),
        home:
            HomePage()); /*BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Favor de autenticarse")));
            }
          },
          builder: (context, state) {
            if (state is AuthSuccessState) {
              return HomePage();
            } else if (state is UnAuthState || state is SignOutSuccessState) {
              return LoginPage();
            }
            return Center(
                child: CircularProgressIndicator(color: Colors.white));
          },
        ));*/
  }
}
