import 'dart:async';
import 'package:dharmlok/src/Home.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashContentState createState() => new _SplashContentState();
}

class _SplashContentState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  var _iconAnimationController;
  var _iconAnimation;

  startTimeout() async {
    var duration = const Duration(seconds: 3);
    return new Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) =>
                MyHomePage(title: 'Dharmlok App')),
        ModalRoute.withName("Home"));
  }

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 3000));
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeInOutCirc);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/om/om.jpg"), // <-- BACKGROUND IMAGE
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color(int.parse("0xFFffffff"))),
            ),
          ),
        ),
      ),
    );
  }
}
