import 'package:flutter/material.dart';
import 'package:appmini/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lime
      ),
      title: 'test1',
      debugShowCheckedModeBanner: false,
      home:Home(),
      
    );
  }
}