import 'package:ceo_transport/screens/auth_screens/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CEO Transport',
      theme: ThemeData(
          brightness: Brightness.dark,
          textTheme: TextTheme(
            bodyText2: TextStyle(fontSize: 20, color: Colors.yellow.shade800),
            subtitle1: TextStyle(fontSize: 18),
            subtitle2: TextStyle(fontSize: 20),
            bodyText1: TextStyle(fontSize: 20, color: Colors.black),
          ),
          primaryColor: Colors.amber),
      home: LoginPage(),
    );
  }
}
