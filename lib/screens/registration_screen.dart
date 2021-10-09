import 'package:flash_chat_demo/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_demo/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _email = "";
  String _password = "";
  bool _isProgressVisible = false;

  CircularProgressIndicator startProgressIndicator() {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
      backgroundColor: Colors.black,
      strokeWidth: 5,
    );
  }

  CircularProgressIndicator stopProgressIndicator() {
    return CircularProgressIndicator(
      value: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Registration"
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: SizedBox(
              height: 40,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: "logo",
                  child: Image.asset("images/flash.png", height: 70, width: 50,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "FLASH CHAT",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40
                  ),
                ),
              )
            ],
          ),
          Flexible(
            child: SizedBox(
              height: 70,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: kTextFieldDecorationEmail,
              onChanged: (value){
                _email = value;
              },
            ),
          ),
          Flexible(
            child: SizedBox(
              height: 70,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: kTextFieldDecorationPassword,
              onChanged: (value) {
                _password = value;
              },
            ),
          ),
          Visibility(
            visible: _isProgressVisible,
            child: LinearProgressIndicator(
              minHeight: 10,
            ),
          ),
          Flexible(
            child: SizedBox(
              height: 70,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: MaterialButton(
              height: 60,
              color: Colors.blueAccent,
              child: Text(
                "Register",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              onPressed: () async{
                if (_email.isNotEmpty && _password.isNotEmpty) {
                  try {
                    setState(() {
                      _isProgressVisible = true;
                    });
                    FirebaseAuth mAuth = FirebaseAuth.instance;
                    await mAuth.createUserWithEmailAndPassword(email: _email, password: _password);
                    setState(() {
                      _isProgressVisible = false;
                    });
                    Navigator.pushNamed(context, ChatScreen.id);
                  } catch (e) {
                    setState(() {
                      _isProgressVisible = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString()
                        ),
                        action: SnackBarAction(
                          onPressed: (){
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                          label: "close",
                        ),
                      )
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Please enter all information!",
                    ),
                    elevation: 5,
                    duration: Duration(
                      seconds: 3
                    ),
                    action: SnackBarAction(
                      label: "close",
                      onPressed: (){
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  ));
                }
              },
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
