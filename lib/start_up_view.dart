import 'package:appafhopades/screens/dashboard/home_page.dart';
import 'package:appafhopades/screens/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class StartupView extends StatefulWidget {
  const StartupView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<StartupView> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 6);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  initScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Lottie.asset('assets/lottie/message-sent-icon.json'),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,
            ),
            Text(
              "Bienvenue sur l\'espace digitale du parti AFHO PADES",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
