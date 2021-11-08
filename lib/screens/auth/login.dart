// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:ceo_transport/constants/constants.dart';
// import 'package:ceo_transport/database/auth_methods.dart';
// import 'package:ceo_transport/home_page.dart';
// import 'package:ceo_transport/models/driver_details.dart';
// import 'package:ceo_transport/tools/custom_button.dart';
// import 'package:ceo_transport/tools/custom_textformfield.dart';
// import 'package:ceo_transport/tools/custom_toast.dart';
// import 'package:ceo_transport/tools/password_textformfield.dart';
// import 'package:ceo_transport/tools/show_loading.dart';
// import 'package:ceo_transport/utilities/custom_validator.dart';
// import 'package:ceo_transport/utilities/utilities.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//   static const String routeName = '/LoginScreen';
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _password = TextEditingController();
//   final GlobalKey<FormState> _key = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
//           child: Form(
//             key: _key,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 _loginWord(context),
//                 const SizedBox(height: 30),
//                 CustomTextFormField(
//                   title: 'Email',
//                   controller: _email,
//                   hint: 'someone@gmail.com',
//                   validator: (String? value) => CustomValidator.email(value),
//                   autoFocus: true,
//                 ),
//                 PasswordTextFormField(controller: _password),
//                 // _forgetPassword(),
//                 CustomTextButton(
//                   onTap: () async {
//                     if (_key.currentState!.validate()) {
//                       showLoadingDislog(context);

//                       final _driver =
//                           await AuthMethod().loginWithEmailAndPassword(
//                         _email.text.trim(),
//                         _password.text.trim(),
//                       );
//                       if (_driver != null) {
//                         driverDetails = _driver;
//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => HomePage(),
//                             ));
//                       } else {
//                         Navigator.of(context).pop();
//                         CustomToast.errorToast(
//                             message: 'email OR password in incorrect');
//                       }
//                     }
//                   },
//                   text: 'Login',
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // GestureDetector _forgetPassword() {
//   //   return GestureDetector(
//   //     onTap: () {
//   //       Navigator.pushNamed(context, ForgetPassword.routeName);
//   //     },
//   //     child: Container(
//   //       padding: const EdgeInsets.all(6),
//   //       alignment: Alignment.centerRight,
//   //       child: const AutoSizeText('Forget password?'),
//   //     ),
//   //   );
//   // }

//   Row _loginWord(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: <Widget>[
//         AutoSizeText(
//           'Login',
//           style: TextStyle(
//             fontSize: 40,
//             fontWeight: FontWeight.bold,
//             color: Theme.of(context).colorScheme.primary,
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.symmetric(vertical: 4),
//           child: Icon(
//             Icons.fiber_manual_record,
//             size: 18,
//           ),
//         )
//       ],
//     );
//   }
// }
