import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'package:weather_app/cubits/weather_cubits/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubits/weather_state.dart';
import 'package:weather_app/models/weatherData_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/search_page.dart';

class HomePage extends StatelessWidget {
  WeatherDataModel? weatherData;
  @override
  Widget build(BuildContext context) {
    weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SearchPage();
                  },
                ));
              },
              icon: const Icon(
                Icons.search,
                size: 32,
              ))
        ],
        title: Text('Weather App'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WeatherSuccess) {
            weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
            return SuccessWidget(weatherData: weatherData);
          } else if (state is WeatherFailed) {
            return const Center(
              child: Text('Some Thing Went Wrong Please Try Again'),
            );
          } else {
            return InitialWidget();
          }
        },
      ),
    );
  }
}

class InitialWidget extends StatelessWidget {
  const InitialWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'there is no Weather  😢  Start',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text('Searching Now  🔍 ',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({
    super.key,
    required this.weatherData,
  });

  final WeatherDataModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        weatherData!.getColor(),
        weatherData!.getColor()[400]!,
        weatherData!.getColor()[300]!,
        weatherData!.getColor()[200]!,
        weatherData!.getColor()[100]!,
        weatherData!.getColor()[50]!,
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            BlocProvider.of<WeatherCubit>(context).cityName!,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text('Updated at : ${weatherData!.date}',
              style: TextStyle(fontSize: 18)),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(weatherData!.getImage()),
              Text('${weatherData!.avgTemp.toInt()}',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              Column(
                children: [
                  Text('Min Temp ${weatherData!.minTemp.toInt()}'),
                  Text('Max Temp  ${weatherData!.maxTemp.toInt()}')
                ],
              )
            ],
          ),
          Spacer(),
          Text(
            '${weatherData!.condition}',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Spacer(
            flex: 3,
          )
        ],
      ),
    );
  }
}
