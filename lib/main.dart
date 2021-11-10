import 'package:ceo_transport/database/user_local_data.dart';
import 'package:ceo_transport/screens/auth_screens/login.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserLocalData.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    UserLocalData.setNotLoggedIn();

    bool isLoggedIn = false;
    isLoggedIn = UserLocalData.getIsLoggedIn;

    String? email;
    String? password;
    if (isLoggedIn) {
      email = UserLocalData.getUserEmail;
      password = UserLocalData.getPassword;
    }
    return MaterialApp(
      title: 'CEO Transport',
      theme: ThemeData(
          brightness: Brightness.dark,
          textTheme: TextTheme(
            bodyText2: TextStyle(fontSize: 20, color: Colors.yellow.shade800),
            subtitle1: TextStyle(fontSize: 18),
            overline: TextStyle(
              fontSize: 24,
              color: Colors.blue,
              fontStyle: FontStyle.italic,
            ),
            subtitle2: TextStyle(fontSize: 20),
            bodyText1: TextStyle(fontSize: 20, color: Colors.black),
          ),
          primaryColor: Colors.amber),
      home: LoginPage(email: email, password: password),
    );
  }
}
