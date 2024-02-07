import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:http/http.dart ' as http;

class WeatherService {
  static const Base_url = "https://api.openweathermap.org/data/2.5/weather";

  final String apikey;
  WeatherService(this.apikey);

  Future<Weather> getweather(String cityname) async {
    final response = await http
        .get(Uri.parse("$Base_url?q=$cityname&appid=$apikey&units=metric"));
    if (response.statusCode == 200) {
      return Weather.fromjson(jsonDecode(response.body));
    } else {
      throw Exception("failed to load weather data");
    }
  }

  Future<String> getCurrentCity() async {
    //get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    //fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // convert the location into a list of placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // extract the city name from the first placemark
    String? city = placemarks[0].locality;
    return city ?? "";
  }
}
