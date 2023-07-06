import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weatherData_model.dart';

WeatherDataModel? weather;

class WeatherGetterModel {
  String baseUrl = 'http://api.weatherapi.com/v1';
  String apiKey = '46b906b11d704fb99ed175314232704';
  Future<WeatherDataModel?> getWeather({required String cityName}) async {
    try {
      Uri url =
          Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=3');
      http.get(url);
      http.Response response = await http.get(url);
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);

      weather = WeatherDataModel.fromjson(data);
      return weather;
    } catch (e) {
      print(e);
    }
  }
}
