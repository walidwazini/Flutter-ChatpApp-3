import 'package:chat_app_2/widgets/RoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';

import './ChatScreen.dart';
import '../constants.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _auth = FirebaseAuth.instance;
  bool showLoading = false;
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
        child: LoadingOverlay(
          color: Colors.black,
          isLoading: showLoading,
          progressIndicator: CircularProgressIndicator(backgroundColor: Colors.pink,),
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 40, 24, 10),
            child: Column( mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(height: 48.0),
                TextField(
                  keyboardType: TextInputType.emailAddress,
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
                 onPressed: () async {
                   setState(() {
                     showLoading = true;
                   });
                   try {
                     final newUser = await _auth.createUserWithEmailAndPassword(
                         email: email!,
                         password: password!
                     );
                     Navigator.pushNamed(context, ChatScreen.id);
                   } catch (e) {
                     print(e);
                   }

                 },
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
