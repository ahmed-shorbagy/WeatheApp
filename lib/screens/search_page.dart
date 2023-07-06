import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'package:weather_app/cubits/weather_cubits/weather_cubit.dart';
import 'package:weather_app/models/weatherData_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';

class SearchPage extends StatelessWidget {
  String? cityName;
  SearchPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serch a City'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            onSubmitted: (data) async {
              cityName = data;
              BlocProvider.of<WeatherCubit>(context)
                  .getWeather(cityName: cityName!);
              BlocProvider.of<WeatherCubit>(context).cityName = cityName;
              Navigator.pop(context);
            },
            decoration: InputDecoration(
                hintText: ' enter a city name',
                contentPadding: EdgeInsets.symmetric(vertical: 32),
                suffixIcon: GestureDetector(
                  child: Icon(Icons.search),
                  onTap: () async {
                    BlocProvider.of<WeatherCubit>(context)
                        .getWeather(cityName: cityName!);
                    Navigator.pop(context);
                  },
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22))),
                label: Text('Search')),
          ),
        ),
      ),
    );
  }
}
