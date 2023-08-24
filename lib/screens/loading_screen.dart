import 'package:flutter/material.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';




class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }
  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    dynamic weatherData = await weatherModel.getLocationData();
    Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen(data: weatherData)
    ));
  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(image: AssetImage('images/my_new_logo.png'))
          ),
          SpinKitSpinningLines(
            color: Colors.red,
            itemCount: 7,
            size: 80,
          ),

        ],
      ),
    );
  }
}
