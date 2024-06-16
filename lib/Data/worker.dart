import 'package:http/http.dart' as http;
import 'dart:convert';

class Worker {
  String location;

  Worker({required this.location});

  String? temp;
  String? humidity;
  String? airspeed;
  String? description;
  String? main;
  String? iconimg;

  Future<void> getData() async {
    try {
      final response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=8ab164eeef06bf637263f601ab338a5d"));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);


        Map<String, dynamic> tempData = data['main'];
        int getHumidity = tempData['humidity'];
        double getTemp = tempData['temp']-273.15;

        Map<String, dynamic> wind = data['wind'];
        double getAirspeed = wind['speed']/0.27777777777778;

        List<dynamic> weatherData = data['weather'];
        Map<String, dynamic> weatherMainData = weatherData[0];
        String getMain = weatherMainData['main'];
        String getDescription = weatherMainData['description'];
        String icon=weatherMainData["icon"].toString();

        temp = getTemp.toString();
        humidity = getHumidity.toString();
        airspeed = getAirspeed.toString();
        description = getDescription;
        main = getMain;
        iconimg=icon;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print(e);
      temp="NA";
      humidity="NA";
      airspeed="NA";
      description="NA";
    }
  }
}
