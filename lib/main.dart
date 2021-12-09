import 'package:ceo_transport/APIs/driver_api.dart';
import 'package:ceo_transport/constants/constants.dart';
import 'package:ceo_transport/database/user_local_data.dart';
import 'package:ceo_transport/home_page.dart';
import 'package:ceo_transport/screens/auth_screens/login.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserLocalData.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? email;
  String? password;
  bool gotDetails = false;
  @override
  void initState() {
    super.initState();
    getToken();
  }

  getDriverDetails(String token) async {
    driverDetails = await DriverApi().getUser(token);
    setState(() {
      gotDetails = true;
    });
  }

  getToken() {}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // UserLocalData.setNotLoggedIn();

    bool isLoggedIn = UserLocalData.getIsLoggedIn;
    print(isLoggedIn);
    // ignore: unnecessary_null_comparison
    if (isLoggedIn != null && isLoggedIn) {
      email = UserLocalData.getUserEmail;
      password = UserLocalData.getPassword;
      token = UserLocalData.getTokenKey;
      print(token);
      getDriverDetails(token!);
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CEO Transport',
      theme: ThemeData(
          brightness: Brightness.dark,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          )),
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
      home: isLoggedIn
          ? HomePage(alreadyLoggedIn: isLoggedIn)
          : LoginPage(email: email, password: password),
    );
  }
}
