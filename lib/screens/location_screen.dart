import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/services.dart';
import 'package:weather_icons/weather_icons.dart';

import 'city_screen.dart';

const apiKey = '34233eb455d9a04036b1fe7761920171';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.data});

  final data;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var sunRiseDateTime;
  var sunSetDateTime;
  int temprature = 0;
  String city = '';
  int id = 0;
  int humidity = 0;
  double windSpeed = 0;
  String weatherIcon = '';
  String message = '';

  @override
  void initState() {
    super.initState();
    updateUI(widget.data);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temprature = 0;
        city = '';
        weatherIcon = 'error';
        message = 'got nothing';
        return;
      }
      var temp = weatherData['main']['temp'];
      temprature = temp.toInt();
      city = weatherData['name'];
      id = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(id);
      message = weatherModel.getMessage(temprature);
      sunRiseDateTime = DateTime.fromMillisecondsSinceEpoch(
          weatherData['sys']['sunrise'] * 1000);
      sunSetDateTime = DateTime.fromMillisecondsSinceEpoch(
          weatherData['sys']['sunset'] * 1000);
      humidity = weatherData['main']['humidity'];
      windSpeed = weatherData['wind']['speed'];
      // sys.sunrise
    });
  }

  WeatherModel weatherModel = WeatherModel();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('images/location_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: const BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        var weatherData = await weatherModel.getLocationData();
                        updateUI(weatherData);
                      },
                      child: const Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var typeName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CityScreen(),
                          ),
                        );
                        if (typeName != null) {
                          WeatherModel weather = WeatherModel();
                          var weatherData =
                              await weather.getCityLocation(typeName);
                          updateUI(weatherData);
                        }
                      },
                      child: const Icon(
                        Icons.location_city,
                        size: 50,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$temprature°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Container(
                  // height: 250,
                  decoration: BoxDecoration(
                      color: const Color(0x25808080),
                      border: Border.all(width: 3),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    WeatherIcons.sunrise,
                                    color: Colors.yellow,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'SUNRISE',
                                    style: kContainerStyle,
                                  ),
                                ],
                              ),
                              Text(
                                sunRiseDateTime.toString().substring(11, 16),
                                style: kContainerStyle,
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            indent: 20,
                            endIndent: 20,
                            width: 10,
                            thickness: 5,
                            color: Colors.black,
                          ),
                          Column(
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    WeatherIcons.sunset,
                                    color: Colors.yellow,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'SUNSET',
                                    style: kContainerStyle,
                                  ),
                                ],
                              ),
                              Text(
                                sunSetDateTime.toString().substring(11, 16),
                                style: kContainerStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                        child: Divider(
                          color: Colors.black,
                          indent: 20.0,
                          thickness: 5.0,
                          endIndent: 20.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Row(
                                children: <Widget>[
                                  Icon(
                                    WeatherIcons.humidity,
                                    size: 30.0,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'HUMIDITY',
                                    style: kContainerStyle,
                                  ),
                                ],
                              ),
                              Text(
                                '$humidity%',
                                style: kContainerStyle,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    WeatherIcons.strong_wind,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'WIND',
                                    style: kContainerStyle,
                                  ),
                                ],
                              ),
                              Text(
                                '$windSpeed m/s',
                                style: kContainerStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$message in $city!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// int id = data['weather'][0]['id'];
// double temp = data['main']['temp'];
// String city = data['name'];
// print('ID = $id  ,Temperature = $temp ,City = $city');
