import 'package:ceo_transport/constants/constants.dart';
import 'package:ceo_transport/tools/custom_toast.dart';
import 'package:http/http.dart' as http;

class ReservationAPI {
  Future<bool> setStatus(
      {required var reservationNo,
      required String token,
      required String type}) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token'
    };
    http.Request request = http.Request(
        'PUT',
        Uri.parse(
            'https://terryd8.sg-host.com/api/reservation/$reservationNo'));

    request.bodyFields = {'type': type};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  additionalChargesAPi(
      {required int? reservationId,
      required String? wait_time,
      required String? add_stop,
      required String? clean_up,
      required String? damage,
      required String? gratuity,
      required String? tax,
      required String? tolls,
      required String? others}) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('PUT',
        Uri.parse('https://terryd8.sg-host.com/api/charges/$reservationId'));
    request.bodyFields = {
      'wait_time': wait_time!,
      'add_stop': add_stop!,
      'clean_up': clean_up!,
      'damage': damage!,
      'gratuity': gratuity!,
      'tax': tax!,
      'tolls': tolls!,
      'others': others!
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      CustomToast.successToast(message: "Values Successfully Setted");
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
