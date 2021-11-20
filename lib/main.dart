import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:chat_app_2/screens/WelcomeScreen.dart';
import 'screens/ChatScreen.dart';
import 'screens/LoginScreen.dart';
import 'package:chat_app_2/screens/RegisterScreen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  //const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(),
        RegisterScreen.id : (context) => RegisterScreen(),
        ChatScreen.id : (context) => ChatScreen(),
        LoginScreen.id : (context) => LoginScreen()
      },
    );
  }
}
