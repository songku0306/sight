import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String apiKey = '6a4c860014844a38fe342be3fab38741';
  String city = 'busan';
  Map<String, dynamic> weatherData = {};

  @override
  void initState() {
    super.initState();
    fetchWeatherData(); // 초기 데이터 로드
    Timer.periodic(
        Duration(hours: 2), (Timer t) => fetchWeatherData()); // 2시간마다 업데이트
  }

  Future<void> fetchWeatherData() async {
    final Uri apiUrl = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey');
    final response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        weatherData = data;
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: weatherData.isNotEmpty
            ? WeatherInfoView(weatherData: weatherData)
            : CircularProgressIndicator(),
      ),
    );
  }
}

class WeatherInfoView extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  WeatherInfoView({required this.weatherData});

  String getWeatherEmoji(String weatherDescription) {
    // 날씨 상태에 따라 이모티콘을 반환하는 함수를 작성하세요.
    // 예를 들어, 'Clear'일 때 ☀️를 반환하고, 'Rain'일 때 🌧️를 반환합니다.
    if (weatherDescription.toLowerCase().contains('clear')) {
      return '☀️';
    } else if (weatherDescription.toLowerCase().contains('rain')) {
      return '🌧️';
    } else if (weatherDescription.toLowerCase().contains('cloud')) {
      return '☁️';
    } else {
      return '❓'; // 기타 날씨 상태 처리
    }
  }

  @override
  Widget build(BuildContext context) {
    final String weatherDescription = weatherData['weather'][0]['description'];
    final double temperature = weatherData['main']['temp'];
    final double windSpeed = weatherData['wind']['speed'];
    final double rainAmount =
        weatherData['rain'] != null ? weatherData['rain']['1h'] : 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Weather: ${getWeatherEmoji(weatherDescription)} $weatherDescription',
          style: TextStyle(fontSize: 24),
        ),
        Text(
          'Temperature: $temperature°C',
          style: TextStyle(fontSize: 24),
        ),
        Text(
          'Wind Speed: $windSpeed m/s',
          style: TextStyle(fontSize: 24),
        ),
        Text(
          'Rain Amount: $rainAmount mm',
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
