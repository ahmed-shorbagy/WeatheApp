import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/cubits/weather_cubits/weather_cubit.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/home_page.dart';

void main() {
  runApp(BlocProvider(
      create: (context) {
        return WeatherCubit();
      },
      child: WeatherApp()));
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch:
              BlocProvider.of<WeatherCubit>(context).weatherModel == null
                  ? Colors.blue
                  : BlocProvider.of<WeatherCubit>(context)
                      .weatherModel!
                      .getColor()),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
