import 'package:ceo_transport/constants/commonUIFunctions.dart';
import 'package:ceo_transport/constants/constants.dart';
import 'package:ceo_transport/database/auth_methods.dart';
import 'package:ceo_transport/database/user_local_data.dart';
import 'package:ceo_transport/screens/auth_screens/forgetPasswordPage.dart';
import 'package:ceo_transport/tools/custom_toast.dart';
import 'package:ceo_transport/tools/show_loading.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String? email;
  final String? password;
  LoginPage({this.email, this.password});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  // GetStorage currentUserStored = GetStorage();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final _textFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.email != null && widget.password != null) {
      _emailController = TextEditingController(text: widget.email!);
      _passwordController = TextEditingController(text: widget.password!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
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
                            "Login To Continue",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                                  val.trim().length < 4) {
                                return "Invalid E-mail!";
                              } else {
                                return null;
                              }
                            },
                            // onSaved: (val) => phoneNo = val,
                            autofocus: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              labelText: "E-mail",
                              labelStyle: TextStyle(fontSize: 15.0),
                              hintText: "Please enter your valid E-mail",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 4,
                          child: TextFormField(
                            obscureText: _obscureText,
                            validator: (val) {
                              if (val == null) {
                                return null;
                              }
                              if (val.length < 6) {
                                return 'Password Too Short';
                              } else {
                                return null;
                              }
                            },
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
                              filled: true,
                              labelText: "Password",
                              hintText: "Enter a valid password, min length 6",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: GestureDetector(
                        //     onTap: () => Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 ForgetPasswordPage())),
                        //     child: Hero(
                        //       tag: "passFor",
                        //       child: Text(
                        //         "Forgot Password?",
                        //         style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 20,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        GestureDetector(
                          onTap: () async {
                            if (_textFormKey.currentState!.validate()) {
                              showLoadingDislog(context);

                              final _driver =
                                  await AuthMethod().loginWithEmailAndPassword(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                              if (_driver != null) {
                                driverDetails = _driver;
                                UserLocalData.setIsLoggedIn(true);
                                print(UserLocalData.getIsLoggedIn);
                                UserLocalData.setUserEmail(
                                    _emailController.text);
                                UserLocalData.setUserPassword(
                                    _passwordController.text);
                                AuthMethod().requestPermission(context);
                              } else {
                                _emailController.clear();
                                _passwordController.clear();
                                CustomToast.errorToast(
                                    message: 'email OR password in incorrect');
                              }
                            }
                          },
                          child: buildSignUpLoginButton(
                              context: context,
                              btnText: "Log In",
                              textColor: Colors.white,
                              hasIcon: false,
                              color: Colors.green),
                        ),

                        SizedBox(
                          height: 20,
                        ),
// Move to Sign Up Page
                      ],
                    ),
                  ),
                ),
              ),
              //  _isLoading ? bouncingGridProgress() : Container(),
            ],
          ),
          // bottomSheet: buildSignUpLoginText(
          //     context: context,
          //     text1: "Don't have an account ",
          //     text2: "Sign Up",
          //     moveToLogIn: false),
        ),
      ),
    );
  }

  // Future<UserData> _loginUser(
  //     {@required String email, @required String password}) async {
  //   final String apiUrl = "https://fudigudi.ro/Fudigudi/webservice/login";
  //   final response = await http.post(apiUrl, body: {
  //     "email": email,
  //     "password": password,
  //     //"register_id": register_id,
  //   });
  //   var result = json.decode(response.body);
  //
  //   if (response.statusCode == 200 && result["status"] == "1") {
  //     final String responseString = response.body;
  //     print("data before storing in local database: " + responseString);
  //     currentUserStored.write("userData", "$responseString");
  //     currentUserStored.write("isLoggedIn", true);
  //
  //     print("stored data" + currentUserStored.read("userData"));
  //     return userDataFromJson(responseString);
  //   } else {
  //     BotToast.showText(text: "Couldn't SignIn.Please try again");
  //     return null;
  //   }
  // }

  // void _handleLogin() async {
  //   final _form = _textFormKey.currentState;
  //
  //   if (_form == null) {
  //     return null;
  //   }
  //   if (_form.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //
  //     final String email = _emailController.text;
  //     final String password = _passwordController.text;
  //
  //     UserData user = await _loginUser(
  //       email: email,
  //       password: password,
  //     );
  //
  //     if (user != null && user.status == "1") {
  //       setState(() {
  //         currentUser = user.result;
  //       });
  //
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       BotToast.showText(
  //         text: "Welcome ${user.result.fname}",
  //       );
  //       Get.offAll(Home());
  //     } else {
  //       BotToast.showText(text: "Couldn't SignIn.Please try again");
  //     }
  //   } else {
  //     BotToast.showText(text: "Enter Valid Data!");
  //   }
  // }
}
