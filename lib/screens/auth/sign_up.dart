// import 'dart:io';

// import 'package:ceo_transport/database/auth_methods.dart';
// import 'package:ceo_transport/database/user_api.dart';
// import 'package:ceo_transport/models/userModel.dart';
// import 'package:ceo_transport/tools/custom_button.dart';
// import 'package:ceo_transport/tools/custom_textformfield.dart';
// import 'package:ceo_transport/tools/custom_toast.dart';
// import 'package:ceo_transport/tools/password_textformfield.dart';
// import 'package:ceo_transport/tools/show_loading.dart';
// import 'package:ceo_transport/utilities/custom_validator.dart';
// import 'package:ceo_transport/utilities/utilities.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({Key? key}) : super(key: key);
//   static const String routeName = '/SignupScreen';
//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final TextEditingController _name = TextEditingController();
//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _password = TextEditingController();
//   final TextEditingController _confirmPassword = TextEditingController();
//   final GlobalKey<FormState> _key = GlobalKey<FormState>();
//   File? _pickedImage;
//   void _submitForm() async {
//     if (_key.currentState!.validate()) {
//       if (_password.text.trim() == _confirmPassword.text.trim()) {
//         showLoadingDislog(context);
//         FocusScope.of(context).unfocus();
//         final User? _user = await AuthMethod().signupWithEmailAndPassword(
//           email: _email.text,
//           password: _password.text,
//         );
//         if (_user == null) {
//           Navigator.of(context).pop();
//           return;
//         }
//         String date = DateTime.now().toString();
//         DateTime dateparse = DateTime.parse(date);
//         String formattedDate =
//             '${dateparse.day}-${dateparse.month}-${dateparse.year}';
//         String _imageURL = '';
//         if (_pickedImage != null) {
//           _imageURL =
//               await UserAPI().uploadImage(File(_pickedImage!.path), _user.uid);
//         }
//         AppUserModel _appUser = AppUserModel(
//           id: _user.uid,
//           name: _name.text.trim(),
//           email: _email.text.trim(),
//           imageUrl: _imageURL,
//           createdAt: Timestamp.now(),
//           joinedAt: formattedDate,
//           isAdmin: false,
//           password: _password.text.trim(),
//         );
//         final bool _save = await UserAPI().addUser(_appUser);
//         if (_save) {
//           CustomToast.successToast(message: 'Signup successfully');
//         } else {
//           Navigator.of(context).pop();
//         }
//       } else {
//         CustomToast.errorToast(
//           message: 'Password and confirm password should be same',
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // resizeToAvoidBottomInset: false,
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
//               children: <Widget>[
//                 _signupLine(context),
//                 const SizedBox(height: 20),
//                 const SizedBox(height: 20),
//                 CustomTextFormField(
//                   title: 'Name',
//                   controller: _name,
//                   autoFocus: true,
//                   validator: (String? value) =>
//                       CustomValidator.lessThen4(value),
//                 ),
//                 CustomTextFormField(
//                   title: 'Email',
//                   controller: _email,
//                   hint: 'test@test.com',
//                   validator: (String? value) => CustomValidator.email(value),
//                 ),
//                 PasswordTextFormField(controller: _password),
//                 PasswordTextFormField(
//                   controller: _confirmPassword,
//                   title: 'Confirm Password',
//                 ),
//                 CustomTextButton(
//                   onTap: () => _submitForm(),
//                   text: 'Sign up',
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Row _signupLine(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: <Widget>[
//         AutoSizeText(
//           'Sign up',
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
