import 'package:ceo_transport/APIs/driver_api.dart';
import 'package:ceo_transport/constants/constants.dart';
import 'package:ceo_transport/database/user_local_data.dart';
import 'package:ceo_transport/models/login_token.dart';
import 'package:ceo_transport/tools/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../home_page.dart';
import '../location_fail_screen.dart';

class AuthMethod {
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://terryd8.sg-host.com/api/login'));
      request.fields.addAll({'email': email, 'password': password});
// "lroberts@limobermuda.com"
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        //print("here");
        String res = await response.stream.bytesToString();

        LoginToken loginToken = loginTokenFromJson(res);
        //print(loginToken.success!.token!);
        token = loginToken.success!.token!;
        UserLocalData.setTokenKey(token!);

        return await DriverApi().getUser(loginToken.success!.token!);
      } else {
        //print(response.reasonPhrase);
      }
    } catch (signUpError) {
      CustomToast.errorToast(message: signUpError.toString());
      return null;
    }
  }
  
  requestPermission(BuildContext context) async {

    var status = await Permission.location.request();
    if (status.isGranted) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(alreadyLoggedIn: false,),
          ));
    } else if (status.isDenied) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LocationFail(),
          ));
    } else if (status.isPermanentlyDenied) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LocationFail(),
          ));
    }
  }
  
}
