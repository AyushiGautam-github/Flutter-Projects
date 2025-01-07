import 'package:flutter/material.dart';
import 'package:clima/screens/loading_screen.dart';
import 'package:geolocator/geolocator.dart';

class location{

  double latitude=0.0;
  double longitude=0.0;
  Future<void> getloc() async{
    try{
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission==LocationPermission.denied || permission==LocationPermission.deniedForever)
      { print('Location permission denied!'); return;}

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitude=position.latitude;
      longitude=position.longitude;
    }
    catch(e){
      print('Error occurred: $e');
    }
  }
}