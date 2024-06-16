import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();
  late String city;

  @override
  void initState() {
    super.initState();
    // You can set an initial city or perform other initializations here if needed
    city = "Unknown"; // Initialize with a default value
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments from the route
    final Map<String, dynamic> info = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    String temp = ((info['temp_value']).toString()).substring(0,5);
    String icon = info['icon_value'];
    String airspeed = ((info["airspeed_value"]).toString()).substring(0,5);
    String humidity = info["hum_value"];
    String main = info["main_value"];
    String desc = info["desc_value"];
    city = info["city_value"];

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("WeatherApp"),
          backgroundColor: Colors.cyanAccent,
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.lightBlueAccent,
                  Colors.blue,
                ],
              ),
            ),
            child: Column(
              children: <Widget>[
                // Search bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if((search.text).replaceAll(" ","")==" "){
                            print("Blank search");
                          }else {
                            Navigator.pushReplacementNamed(context, "/loading", arguments: {
                              "searchText": search.text,
                            });
                          }
                        },
                        child: Container(
                          child: const Icon(Icons.search),
                          margin: const EdgeInsets.fromLTRB(2, 0, 7, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: search,
                          decoration: const InputDecoration(
                            hintText: "Enter City Name",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Weather description
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Image.network("https://openweathermap.org/img/wn/$icon@2x.png"),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("$desc", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Text("In $city", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Temperature display
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(WeatherIcons.thermometer, size: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$temp", style: const TextStyle(fontSize: 90, fontWeight: FontWeight.bold)),
                                const Text("°C", style: TextStyle(fontSize: 30)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Additional weather info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        padding: const EdgeInsets.all(20),
                        height: 200,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(WeatherIcons.windy, size: 40),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Text("$airspeed", style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                            const Text("km/hr"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                        padding: const EdgeInsets.all(20),
                        height: 200,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(WeatherIcons.humidity, size: 40),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Text("$humidity", style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                            const Text("Percent"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Footer
                Container(
                  padding: const EdgeInsets.only(top: 80,bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const <Widget>[
                      Text("Made By- Chinmaya Kolhe"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
