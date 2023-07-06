import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubits/weather_state.dart';
import 'package:weather_app/models/weatherData_model.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());
  WeatherDataModel? weatherModel;
  String? cityName;
  set weatherData(WeatherDataModel? weatherData) {}
  void getWeather({required String cityName}) async {
    emit(WeatherLoading());
    try {
      weatherModel = await WeatherGetterModel().getWeather(cityName: cityName);
      emit(WeatherSuccess());
    } catch (e) {
      emit(WeatherFailed());
    }
  }
}
