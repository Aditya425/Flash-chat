import 'package:flash_chat_demo/screens/login_screen.dart';
import 'package:flash_chat_demo/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "welcome_screen";
  @override
  State<StatefulWidget> createState() {
    return _WelcomeScreenState();
  }

}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(
        seconds: 1
      ),
      vsync: this
    );

    _animation = ColorTween(begin: Colors.black, end: Colors.white).animate(_controller);

    _controller.forward();

    _animation.addListener(() {
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _animation.value,
      appBar: AppBar(
        title: Text(
            "Flash Chat",
        style: TextStyle(
          color: Colors.black
        )),
        elevation: 5,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: "logo",
                    child: Image.asset(
                      "images/flash.png", height: 100, width: 70,)
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      "Flash Chat",
                      speed: Duration(
                        milliseconds: 500,
                      ),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 40
                      )
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 59,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MaterialButton(
              height: 40,
              color: Colors.blueAccent,
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
              onPressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MaterialButton(
              height: 40,
              color: Colors.blueAccent,
              child: Text(
                "Register",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
              onPressed: (){
                Navigator.pushNamed(context, RegistrationScreen.id);
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