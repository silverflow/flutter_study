import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/screens/weather_screen.dart';

const apiKey = 'de82eee176b6b8d86b64a39f8bc492fe';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late double latitue3;
  late double longitude3;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLoation();
    latitue3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    print(latitue3);
    print(longitude3);

    Network network = Network(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitue3&lon=$longitude3&appid=$apiKey&units=metric");
    var weatherData = await network.getJsonData();
    print("weatherData:" + weatherData);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherScreen(
        parseWeatherData: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Get my location'),
          onPressed: null,
        ),
      ),
    );
  }
}
