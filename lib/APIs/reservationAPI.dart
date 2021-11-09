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
}
