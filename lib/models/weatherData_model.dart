import 'package:flutter/material.dart';

class WeatherDataModel {
  final String date;
  final double avgTemp;
  final double maxTemp;
  final double minTemp;
  final String condition;

  WeatherDataModel(
      {required this.date,
      required this.avgTemp,
      required this.maxTemp,
      required this.minTemp,
      required this.condition});
  factory WeatherDataModel.fromjson(dynamic data) {
    var jsondata = data["forecast"]["forecastday"][0]["day"];

    return WeatherDataModel(
        date: data["location"]["localtime"],
        avgTemp: jsondata["avgtemp_c"],
        maxTemp: jsondata["maxtemp_c"],
        minTemp: jsondata["mintemp_c"],
        condition: jsondata["condition"]["text"]);
  }
  @override
  String toString() {
    return 'date=$date   avgtemp=$avgTemp   mintemp=$minTemp';
  }

  String getImage() {
    if (condition == 'Clear' || condition == 'Light Cloud') {
      return 'assets/images/clear.png';
    } else if (condition == 'Sheet' ||
        condition == 'Snow' ||
        condition == 'Hail') {
      return 'assets/images/snow.png';
    } else if (condition == 'Heavy Cloud') {
      return 'assets/images/cloudy.png';
    } else if (condition == 'Light Rain' ||
        condition == 'Heavy Rain' ||
        condition == 'Moderate rain') {
      return 'assets/images/rainy.png';
    } else if (condition == 'Thunderstorm') {
      return 'assets/images/thunderstorm.png';
    } else {
      return 'assets/images/clear.png';
    }
  }

  MaterialColor getColor() {
    if (condition == 'Clear' || condition == 'Light Cloud') {
      return Colors.orange;
    } else if (condition == 'Sheet' ||
        condition == 'Snow' ||
        condition == 'Hail') {
      return Colors.cyan;
    } else if (condition == 'Heavy Cloud') {
      return Colors.blueGrey;
    } else if (condition == 'Light Rain' ||
        condition == 'Heavy Rain' ||
        condition == 'Moderate rain') {
      return Colors.cyan;
    } else if (condition == 'Thunderstorm') {
      return Colors.teal;
    } else {
      return Colors.orange;
    }
  }
}
