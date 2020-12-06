import 'package:dharmlok/src/Home.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(int.parse("0xFF003975")),
      ),
      home: MyHomePage(title: 'Dharmlok App'),
    );
  }
}
