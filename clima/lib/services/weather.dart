import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';

const apikey='fa5b38203dd80d74ded95bb854c57aec';
const openweathermap='https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getcityweather(String cityname) async{
    var url='$openweathermap?q=$cityname&appid=$apikey&units=metric';
    networkhelper nh2=networkhelper(url);
    var weatherdata= await nh2.getData();
    return weatherdata;
  }



  Future<dynamic> getlocationWeather() async{
      location lc=location();
      await lc.getloc();
      networkhelper nh=networkhelper('$openweathermap?lat=${lc.latitude}&lon=${lc.longitude}&appid=$apikey&units=metric');
      var weatherdata=await nh.getData();
      return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
