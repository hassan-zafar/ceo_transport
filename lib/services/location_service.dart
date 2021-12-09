import 'dart:async';
import 'package:ceo_transport/constants/constants.dart';
import 'package:ceo_transport/database/location_submit.dart';
import 'package:location/location.dart' as loc;

class LocationService {
  bool _isRunning = false;
  Future<void> listenLocation(loc.Location location, int milliseconds, double? meters) async {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (!_isRunning) {
        _requestPermission(location);
      }
    });
    location.enableBackgroundMode(enable: true);
    location.changeSettings(accuracy: loc.LocationAccuracy.high, interval: milliseconds, distanceFilter: meters);
    location.onLocationChanged.handleError((onError) async {
      print(onError);
    }).listen((loc.LocationData currentLocation)  async {
      if(currentLocation.latitude!=null && currentLocation.longitude!=null){
        var lat = currentLocation.latitude!.toString();
        var lng = currentLocation.longitude!.toString();
        await LocationMethod().locationSubmit(token!,lng, lat);
      }
    });
  }
  _requestPermission(loc.Location location) async {
    bool _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled){
      _isRunning = true;
      _serviceEnabled = await location.requestService();
      if(!_serviceEnabled){
        _requestPermission(location);
      }else{
        _isRunning = false;
      }
    }
  }

}