import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

import 'home_page.dart';

class LocationFail extends StatefulWidget {
  LocationFail({Key? key}) : super(key: key);

  @override
  _LocationFailState createState() => _LocationFailState();
}

class _LocationFailState extends State<LocationFail> {
  final loc.Location location = loc.Location();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: failUI(),
    );
  }
  @override
  void initState(){
    super.initState();
    _requestPermission();
  }

  Widget failUI(){
    return Container(
    );
  }

  _requestPermission() async {bool _serviceEnabled = await location.serviceEnabled();
  var status = await Permission.location.request();
  if(!_serviceEnabled){
    _serviceEnabled = await location.requestService();
    if(_serviceEnabled){
      if (status.isGranted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(alreadyLoggedIn: false,),
            ));
      } else if (status.isDenied) {
        _requestPermission();
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    }else {
      _requestPermission();
    }
  }else{
    if (status.isGranted) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(alreadyLoggedIn: false,),
          ));
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
  }

}