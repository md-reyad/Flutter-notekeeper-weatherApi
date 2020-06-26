import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class Weather extends StatefulWidget {
  final Color color;

  Weather(this.color);

  @override
  State<StatefulWidget> createState() {
    return getContent();
  }
}

// ignore: camel_case_types
class getContent extends State<Weather> {
  var tamp;
  var description;
  var currently;
  var windSpeed;
  var humidity;
  var cityName;
  var feelLike;

  Future getWeather() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    var long = position.longitude;
    var lat = position.latitude;
    http.Response response = await http.get("http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&units=metric&appid=eb6d4511987dc03f654f83a9f77c5983");
    var result = jsonDecode(response.body);

    setState(() {
      this.tamp = result['main']['temp'].round();
      this.feelLike = result['main']['feels_like'].round();
      this.humidity = result['main']['humidity'];
      this.description = result['weather'][0]['description'];
      this.currently = result['weather'][0]['main'];
      this.windSpeed = result['wind']['speed'];
      this.cityName = result['name'];
    });
    print(this.currently);
  }



  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Weather"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.70,
                width: MediaQuery.of(context).size.width,
//                color: Colors.black12,
//               if(1)
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: currently == "Rain" ? AssetImage("images/rain.gif",) : AssetImage("images/dark.jpg",),
                    fit: BoxFit.cover,

                  ),
                ),
//              padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[getAssetImage()],
                    ),
                    Column(
                      children: [
                        Container(
//                  decoration: BoxDecoration(
//                      border: Border.all(
//                        color: Color(0xff000000),
//                        width: 4,
//                      )),
//                          decoration: BoxDecoration(
//                            image: DecorationImage(
//                              image: AssetImage("images/rain.gif",),
//                              fit: BoxFit.cover,
//
//                            ),
//                          ),

                          padding: EdgeInsets.only(top: 50, left: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Bangladesh",
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                cityName != null ? cityName.toString():"...",
                                style: TextStyle(
                                    fontSize: 25, height: 1.5), // no impact
                              ),
                              Text(
                                tamp != null ? tamp.toString() + "\u00b0 C"
                                    : "...",
                                style: TextStyle(
                                    fontSize: 35, height: 1.3), // no impact
                              ),
                              Text(
                                feelLike != null ? "Feel like "+feelLike.toString() + "\u00b0 C"
                                    : "",
//                                style: TextStyle(
//                                    fontSize: 14), // no impact
                              ),
                            ],
                          ),
                        ),
//                Icon(Icons.timer, color: Colors.green[500]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(15),
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(FontAwesomeIcons.temperatureLow),
                        title: Text("Temperature"),
                        trailing: Text(tamp != null
                            ? tamp.toString() + "\u00b0"
                            : "Loading"),
                        onTap: () {
                          getWeather();
                        },
                      ),
                      ListTile(
                        leading: Icon(FontAwesomeIcons.cloud),
                        title: Text("Weather"),
                        trailing: Text(description != null
                            ? description.toString()
                            : "Loading"),
                      ),
                      ListTile(
                        leading: Icon(FontAwesomeIcons.sun),
                        title: Text("Temperature humidity"),
                        trailing: Text(
                            humidity != null ? humidity.toString() : "Loading"),
                      ),
                      ListTile(
                        leading: Icon(FontAwesomeIcons.wind),
                        title: Text("Windy speed"),
                        trailing: Text(windSpeed != null
                            ? windSpeed.toString()
                            : "Loading"),
                      ),
                    ],
                  )),
            )
          ],
        )

//        color: color,
//      ),
        );
  }
}

Widget getAssetImage() {
  AssetImage assetImage = AssetImage('images/weather.png');
  Image image = Image(
    image: assetImage,
    height: 170,
    width: 170,
  );
  return Container(
//    decoration: BoxDecoration(
//        border: Border.all(
//          color: Color(0xff000000),
//          width: 4,
//        )),
    child: image,
    padding: EdgeInsets.only(top: 20, left: 15),
  );
}
