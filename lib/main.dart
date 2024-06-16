import 'package:flutter/material.dart';
import 'package:weatherapp/Activity/home.dart';
import 'package:weatherapp/Activity/loading.dart';
import 'package:weatherapp/Activity/location.dart';
void main() {
  runApp(MaterialApp(
    routes: {
      "/": (context) => Loading(),
      "/home":(context) => Home(),
      "/loading":(context)=> Loading(),
    },
  ));
}
