import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class Weatherscreen extends StatefulWidget {
  const Weatherscreen({super.key});

  @override
  State<Weatherscreen> createState() => _WeatherscreenState();
}

class _WeatherscreenState extends State<Weatherscreen> {
  //api key :
  final _weatherservice = WeatherService("bf4ac9a2ef71fc5c6fb9de071424b52d");
  Weather? _weather;
  // fetch weather
  _fetchweather() async {
    //get the current city
    String cityname = await _weatherservice.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherservice.getweather(cityname);
      setState(
        () {
          _weather = weather;
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchweather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //city name
            Text(_weather?.cityname ?? "loading city .."),
            // animation
            Lottie.asset("assets/sunny.json"),
            // temperature
            Text("${_weather?.temperature} C"),
            Text(_weather?.maincondition ?? ""),
          ],
        ),
      ),
    );
  }
}
