import 'package:flutter/material.dart';
import 'package:responsive/weather_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: WeatherData(), // WeatherDataウィジェットを表示
      ),
    );
  }
}
