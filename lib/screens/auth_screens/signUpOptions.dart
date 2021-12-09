import 'package:ceo_transport/constants/commonUIFunctions.dart';
import 'package:ceo_transport/constants/constants.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _textFormKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool _obscureText = true;
  TextEditingController _locationController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  bool _obscureText2 = true;
  TextEditingController _confirmPasswordController = TextEditingController();
  String registerId = Uuid().v4();
  String socialId = Uuid().v4();


  //final currentUserStored = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: backgroundColorBoxDecoration(),
      child: Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Center(
                  child: Form(
                    key: _textFormKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Hero(
                              tag: "logo",
                              child: Image.asset(
                                logo,
                                height: 90,
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Sign Up To Continue",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
//Name
                        Card(
                          elevation: 4,
                          child: TextFormField(
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null) {
                                return null;
                              }
                              if (val.isEmpty) {
                                return "Shouldn't be empty";
                              } else if (val.trim().length < 4) {
                                return "Name Too short";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (val) => phoneNo = val,
                            autofocus: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              //enabledBorder: InputBorder.none,
                              filled: true,
                              labelText: "Name",
                              labelStyle: TextStyle(fontSize: 15.0),
                              hintText: "Should be at least 4 character long",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
//Email
                        Card(
                          elevation: 4,
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null) {
                                return null;
                              }
                              if (val.isEmpty) {
                                return "Field is Empty";
                              } else if (!val.contains("@") ||
                                  val.trim().length < 7) {
                                return "Invalid Email Address!";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (val) => phoneNo = val,
                            autofocus: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Email Address",
                              filled: true,
                              labelStyle: TextStyle(fontSize: 15.0),
                              hintText:
                                  "Please enter your valid E-mail address",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
//Phone Number
                        Card(
                          elevation: 4,
                          child: TextFormField(
                            controller: _phoneNoController,
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if (val == null) {
                                return null;
                              }
                              if (val.trim().length < 7 || val.isEmpty) {
                                return "Phone number too short";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (val) => phoneNo = val,
                            autofocus: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Phone Number",
                              filled: true,
                              labelStyle: TextStyle(fontSize: 15.0),
                              hintText: "Please enter your Phone Number",
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
//Password
                        Card(
                          elevation: 4,
                          child: TextFormField(
                            obscureText: _obscureText,
                            validator: (val) => val != null && val.length < 6
                                ? 'Password Too Short'
                                : null,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              border: InputBorder.none,
                              labelText: "Password",
                              filled: true,
                              hintText: "Enter a valid password, min length 6",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
//Confirm Password
                        Card(
                          elevation: 4,
                          child: TextFormField(
                            obscureText: _obscureText2,
                            validator: (val) => val != null && val.length < 6
                                ? 'Password Too Short'
                                : null,
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText2 = !_obscureText2;
                                  });
                                },
                                child: Icon(_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              border: InputBorder.none,
                              labelText: "Confirm Password",
                              filled: true,
                              // fillColor: Colors.white,
                              hintText: "Re-Enter Password",
                            ),
                          ),
                        ),
                        Card(
                          elevation: 4,
                          child: TextFormField(
                            controller: _locationController,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: "Enter Your Location",
                              labelText: "Enter Your Location",
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        GestureDetector(
                          //onTap: _handleSignUp,
                          child: buildSignUpLoginButton(
                            context: context,
                            btnText: "Sign Up",
                            hasIcon: false,
                            color: Colors.green,
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // _isLoading ? bouncingGridProgress() : Container(),
          ],
        )),
        bottomSheet: buildSignUpLoginText(
            context: context,
            text1: "Already a member? ",
            text2: "Login",
            moveToLogIn: true),
      ),
    );
  }

  // void _handleSignUp() async {
  //   final _form = _textFormKey.currentState;
  //   if (_form == null) {
  //     return null;
  //   }
  //   if (_form.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     String signUpUrl = 'https://fudigudi.ro/Fudigudi/webservice/signup';
  //     String socialLoginUrl =
  //         'https://fudigudi.ro/Fudigudi/webservice/social_login';
  //
  //     var data = {
  //       "fname": _nameController.text,
  //       "contact": _phoneNoController.text,
  //       "email": _emailController.text,
  //       "password": _passwordController.text,
  //       "lat": position.latitude,
  //       "lon": position.longitude,
  //       "location": _locationController.text,
  //       "register_id": registerId,
  //       "social_id": socialId
  //     };
  //     var request = http.MultipartRequest(
  //         'POST', Uri.parse(signUpUrl));
  //     request.fields.addAll(data);
  //
  //     http.StreamedResponse response = await request.send();
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     if (response.statusCode == 200) {
  //       String futureResponseBody = await response.stream.bytesToString();
  //       String tempResponseBody = futureResponseBody.toString();
  //       print("tempResponseBody" + "$tempResponseBody");
  //       //UserData user = userDataFromJson(tempResponseBody);
  //       var user = json.decode(tempResponseBody);
  //       print("user" + "${user["result"]}");
  //       print("data before storing in local database: " + tempResponseBody);
  //       currentUserStored.write("userData", "$tempResponseBody");
  //       currentUserStored.write("isLoggedIn", true);
  //
  //       print("stored data" + currentUserStored.read("userData"));
  //       if (user["status"] == "1") {
  //         setState(() {
  //           currentUser = AppUser.fromJson(user["result"]);
  //         });
  //         if (currentUser == null) {
  //           return null;
  //         } else {
  //           var name = currentUser?.fname;
  //           BotToast.showText(text: "Welcome $name", align: Alignment.center);
  //           Navigator.push(
  //               context, MaterialPageRoute(builder: (context) => Home()));
  //         }
  //       } else {
  //         BotToast.showText(text: "${user["result"]}", align: Alignment.center);
  //       }
  //     } else {
  //       BotToast.showText(text: "Couldn't SignUp Please try again");
  //     }
  //   } else {
  //     BotToast.showText(text: "Enter Valid Data", align: Alignment.center);
  //   }
  // }

}
