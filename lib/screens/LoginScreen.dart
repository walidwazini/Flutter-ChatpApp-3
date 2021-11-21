import 'package:flutter/material.dart';

import '../widgets/RoundedButton.dart';
import '../constants.dart';
import './WelcomeScreen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _hiddenPass = true;

  void _togglePassView(){
    if (_hiddenPass == true){
      _hiddenPass = false;
    } else {
      _hiddenPass = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: _hiddenPass,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your Password',
                suffixIcon: InkWell(
                    onTap: _togglePassView,
                    child: _hiddenPass? Icon(Icons.visibility_off) : Icon(Icons.visibility)
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              title: 'Log In ', colour: Colors.pinkAccent,
              onPressed: (){

              },
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextButton(
                    child: Text('Go Back',),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Spacer(flex: 2,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
