import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    getlocation();
    super.initState();
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

   void getlocation() async{

      WeatherModel wm=WeatherModel();
      var weatherdata=await wm.getlocationWeather();
     Navigator.push(context, MaterialPageRoute(builder: (context) {
       return LocationScreen(locationweather: weatherdata); // Pass data here
     }));
   }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
        ),
      ),
    );
  }
}
