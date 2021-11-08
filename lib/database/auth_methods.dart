import 'package:ceo_transport/APIs/driver_api.dart';
import 'package:ceo_transport/constants/constants.dart';
import 'package:ceo_transport/models/login_token.dart';
import 'package:ceo_transport/tools/custom_toast.dart';
import 'package:http/http.dart' as http;

class AuthMethod {
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://terryd8.sg-host.com/api/login'));
      request.fields
          .addAll({'email': "lroberts@limobermuda.com", 'password': password});
// "lroberts@limobermuda.com"
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print("here");
        String res = await response.stream.bytesToString();

        LoginToken loginToken = loginTokenFromJson(res);
        print(loginToken.success!.token!);
        token = loginToken.success!.token!;
        return await DriverApi().getUser(loginToken.success!.token!);
      } else {
        print(response.reasonPhrase);
      }
    } catch (signUpError) {
      CustomToast.errorToast(message: signUpError.toString());
      return null;
    }
  }
}
