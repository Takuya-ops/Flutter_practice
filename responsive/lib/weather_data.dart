import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherData extends StatefulWidget {
  @override
  _WeatherDataState createState() => _WeatherDataState();
}

class _WeatherDataState extends State<WeatherData> {
  final String apiKey = 'APIKey'; // OpenMapWeather APIキーを入力してください
  final String cityName = 'Japan'; // 取得したい都市の名前を指定してください

  Future<Map<String, dynamic>> fetchWeatherData() async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Widget buildWeatherInfo(Map<String, dynamic>? weatherData) {
    if (weatherData == null) {
      return Center(child: Text('No weather data available'));
    }

    final temperature = weatherData['main']?['temp'];
    final weatherDescription = weatherData['weather']?[0]['description'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('City: $cityName'),
        SizedBox(height: 20),
        Text('Temperature: $temperature°C'),
        SizedBox(height: 20),
        Text('Weather: $weatherDescription'),
      ],
    );
  }

  Widget buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget buildError(dynamic error) {
    return Center(child: Text('Error: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchWeatherData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildLoading();
        } else if (snapshot.hasError) {
          return buildError(snapshot.error);
        } else {
          return buildWeatherInfo(snapshot.data);
        }
      },
    );
  }
}
