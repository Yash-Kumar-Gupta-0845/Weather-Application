// to call the api
// require some http request 
// require http flutter package
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class WeatherApiClient{
  Future<Weather>? getCurrentWeather(String?location)async{
    var endpoint = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&APPID=e59bb4da530b9e5bdc59c763db2f4a33");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    //Weather weather = Weather.fromJson(body)
    print(Weather.fromJson(body).cityName);
    return Weather.fromJson(body);
  }
}

