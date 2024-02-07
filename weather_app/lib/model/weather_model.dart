class Weather {
  final String cityname;
  final String temperature;
  final String maincondition;
  // by deafult constructor
  Weather({
    required this.cityname,
    required this.maincondition,
    required this.temperature,
  });
  //named constuctor
  factory Weather.fromjson(Map<String, dynamic> json) {
    return Weather(
      cityname: json["name"],
      temperature: json["main"]["temp"].toString(),
      maincondition: json["weather"][0]["main"],
    );
  }
}
