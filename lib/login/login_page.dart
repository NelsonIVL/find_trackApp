import 'package:find_track/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SignInScreen(
          providerConfigs: [
            EmailProviderConfiguration(),
            GoogleProviderConfiguration(clientId: "")
          ],
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            }),
          ],
        ),
      ),
    );
  }
}
