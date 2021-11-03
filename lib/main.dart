import 'package:ceo_transport/home_page.dart';
import 'package:ceo_transport/screens/auth/login.dart';
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
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
          ),
          primaryColor: Colors.amber),
      home: LoginScreen(),
    );
  }
}
