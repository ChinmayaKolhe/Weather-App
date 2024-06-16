import 'package:flutter/material.dart';
import 'package:weatherapp/Data/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String? temp;
  String? hum;
  String? airspeed;
  String? desc;
  String? main;
  String? icon;
  String city = "Mumbai";
  bool isLoading = true;

  void startApp(String city) async {
    Worker instance = Worker(location: city);
    await instance.getData();
    setState(() {
      temp = instance.temp;
      hum = instance.humidity;
      airspeed = instance.airspeed;
      desc = instance.description;
      main = instance.main;
      icon = instance.iconimg;
      isLoading = false;
    });
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      "temp_value": temp,
      "hum_value": hum,
      "airspeed_value": airspeed,
      "desc_value": desc,
      "main_value": main,
      "icon_value": icon,
      "city_value": city,
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic>? search = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      if (search != null && search['searchText'] != null) {
        city = search['searchText'];
      }
      startApp(city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: isLoading
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100),
              Image.asset("images/weather-icon.png", width: 300),
              SizedBox(height: 80),
              Text(
                "Weather App",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 70),
              SpinKitFadingCircle(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.pinkAccent : Colors.black,
                    ),
                  );
                },
              ),
              SizedBox(height: 300),
              Text(
                "Made By-Chinmaya Kolhe",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          )
              : Container(), // Display an empty container once loading is done
        ),

      ),
      backgroundColor: Color.fromRGBO(0, 255, 255, 30),

    );
  }
}
