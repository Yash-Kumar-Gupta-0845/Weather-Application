import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_api_calling.dart';
import 'package:weather_app/views/additional_information.dart';
import 'package:weather_app/views/current_weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key?key}) : super(key:key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // calling the api
  WeatherApiClient client = WeatherApiClient();
  
  Weather? data;
  /*@override
  void initState(){
    super.initState();
    client.getCurrentWeather("London");
  }*/

  Future<void> getData() async{
    data = await client.getCurrentWeather("London");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: AppBar(
        backgroundColor: Color(0xFFf9f9f9),
        elevation: 0.0,
        title: const Text(
          "Weather App",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(onPressed: (){},
        //Menu bar
         icon: Icon(Icons.menu),
         color: Colors.black,
         ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            // for displaying the data if we get from api
            return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          currentWeather(Icons.wb_sunny_rounded, "${data!.temp}\u2109", "${data!.cityName}"),
                          SizedBox(
                            height: 60.0,
                          ),
                          Text(
                            "Additional Information",
                            style: TextStyle(
                            fontSize: 24.0,
                            color: Color(0xdd212121),
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            height: 20.0,
                          ),
                          additionlInformation("${data!.wind}", "${data!.humidity}", "${data!.pressure}", "${data!.feels_like}"),
                        ],
                    );
            }else if( snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child:CircularProgressIndicator(),
            );
          }
          return Container();
        },
      )
      /*Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          currentWeather(Icons.wb_sunny_rounded, "26.3", "Delhi"),
          SizedBox(
            height: 60.0,
          ),
          Text(
            "Additional Information",
            style: TextStyle(
              fontSize: 24.0,
              color: Color(0xdd212121),
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          SizedBox(
            height: 20.0,
          ),
          additionlInformation("24", "2", "1014", "Hot"),
        ],
      ),*/
    );
  }
}
