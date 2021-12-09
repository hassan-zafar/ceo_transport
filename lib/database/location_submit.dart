import 'package:ceo_transport/tools/custom_toast.dart';
import 'package:http/http.dart' as http;

class LocationMethod {
  Future locationSubmit(String token, String lat, String lng) async {
    try {
      var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      };
      var response = await http.post(
          Uri.parse('https://terryd8.sg-host.com/api/location'),
          headers: headers,
          body: {'latitude': lat, 'longitude': lng});
      print("statusCode ${response.statusCode}");
      print("body ${response.body}");

    } catch (locationError) {
      CustomToast.errorToast(message: locationError.toString());
      print("locationSubmitERROR2 ${locationError.toString()}");
      return null;
    }
  }
}