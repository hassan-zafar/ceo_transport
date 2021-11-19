import 'package:ceo_transport/models/driver_details.dart';

DriverDetails? driverDetails;
String logo = "assets/images/logo.png";
String forgetPassPageIcon = "assets/images/forgetPassIcon.png";
String? token;
List<int> allCompletedJobs = [];
List<int> allNoShows = [];
List buttonSelectedStatus = [
  'en_route',
  'on_location',
  'invehicle',
  'wait_time',
  'wait_time_passenger',
  'no_show',
  'additional_charges_applied',
  'done'
];
