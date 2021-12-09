import 'dart:developer';

import 'package:ceo_transport/models/driver_details.dart';
import 'package:ceo_transport/tools/custom_toast.dart';
import 'package:http/http.dart' as http;

class DriverApi {
  Future<DriverDetails> getUser(String token) async {
    var headers = {
      'Authentication': 'Bearer $token',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST', Uri.parse('https://terryd8.sg-host.com/api/details'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("in driver api");
    if (response.statusCode == 200) {
      String res = await response.stream.bytesToString();
      print("reservations detail ${res}");
      log(res);
      DriverDetails driverDetails = await driverDetailsFromJson(res);
      return driverDetails;
    } else {
      CustomToast.errorToast(message: "Error occurred");
      print(response.reasonPhrase);
      DriverDetails? driverDetails;
      return driverDetails!;
    }
  }
  
}
