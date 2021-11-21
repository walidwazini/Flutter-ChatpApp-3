import 'package:chat_app_2/widgets/RoundedButton.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  String? email;
  String? password;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 40, 24, 10),
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
                 email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Email'),
              ),
              SizedBox(
                height: 28.0,
              ),
              TextField(
                obscureText: _hiddenPass,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your Password',
                  suffixIcon: InkWell(
                      onTap: _togglePassView,
                      child: _hiddenPass? Icon(Icons.visibility_off) : Icon(Icons.visibility)
                  ),
                ),
              ),
              SizedBox(height: 24.0,),
             RoundedButton(
               title: 'Register', colour: Colors.red,
               onPressed: (){
                 print(email);
               },
             )
            ],
          ),
        ),
      ),
    );
  }
}
