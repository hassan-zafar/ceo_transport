import 'package:ceo_transport/screens/auth_screens/login.dart';
import 'package:ceo_transport/screens/auth_screens/signUpOptions.dart';
import 'package:flutter/material.dart';

buildSignUpLoginButton(
    { required BuildContext context,
    required String btnText,
     String? assetImage,
    bool hasIcon = false,
    double fontSize = 20,
    Color color = Colors.white,
    double leftRightPadding = 20.0,
    textColor = Colors.black}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
    child: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color,
      ),
      child: hasIcon
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 8, bottom: 8),
                  child: Image.asset(
                    assetImage!,
                    height: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    btnText,
                    style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  btnText,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
    ),
  );
}

buildSignUpLoginText(
    {required BuildContext context,
     required String text1,
     required String text2,
     required bool moveToLogIn}) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text1,
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        moveToLogIn ? LoginPage() : SignUpPage())),
            child: Text(
              text2,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      )
      // RichText(
      //   text: TextSpan(
      //       text: "Already have an account? ",
      //       style: TextStyle(fontSize: 15.0, color: Colors.black),
      //       children: [
      //         TextSpan(
      //           text: 'Log In',
      //           style: TextStyle(
      //               fontWeight: FontWeight.bold,
      //               fontSize: 18.0,
      //               fontStyle: FontStyle.italic),recognizer: _gestureRecognizer
      //         ),
      //       ]),
      // ),
      );
}
