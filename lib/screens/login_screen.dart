import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_demo/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_demo/constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = "";
  String _password = "";
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen",
        style: TextStyle(
          color: Colors.black
        ),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Hero(
                  tag: "logo",
                    child: Image.asset(
                      "images/flash.png", width: 70, height: 50,)
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  "Flash Chat",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
          Flexible(
            child: SizedBox(
              height: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: kTextFieldDecorationEmail,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value){
                _email = value;
              },
            ),
          ),
          Flexible(
            child: SizedBox(
              height: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: kTextFieldDecorationPassword,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onChanged: (value){
                _password = value;
              },
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: LinearProgressIndicator(),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: SizedBox(
              height: 70,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: MaterialButton(
              color: Colors.blueAccent,
              onPressed: () async{
                if (_email.isNotEmpty && _password.isNotEmpty) {
                  try {
                    setState(() {
                      _isVisible = true;
                    });
                    FirebaseAuth mAuth = FirebaseAuth.instance;
                    await mAuth.signInWithEmailAndPassword(
                        email: _email, password: _password);
                    setState(() {
                      _isVisible = false;
                    });
                    Navigator.pushNamed(context, ChatScreen.id);
                  } catch (e) {
                    setState(() {
                      _isVisible = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString()
                        ),
                        duration: Duration(
                          seconds: 3
                        ),
                        action: SnackBarAction(
                          label: "close",
                          onPressed: (){
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                        ),
                      )
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Please enter all information!"
                      ),
                      action: SnackBarAction(
                        label: "close",
                        onPressed: (){
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    )
                  );
                }
              },
              height: 50,
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.black
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
            ),
          )
        ],
      ),
    );
  }
}
