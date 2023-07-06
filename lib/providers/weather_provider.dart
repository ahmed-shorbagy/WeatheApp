import 'package:flutter/material.dart';
import 'package:weather_app/models/weatherData_model.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherDataModel? _weatherData;
  String? cityName;
  set weatherData(WeatherDataModel? weahter) {
    _weatherData = weahter;
    notifyListeners();
  }

  WeatherDataModel? get WeatherData => _weatherData;
}
