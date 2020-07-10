import 'dart:async';
import 'dart:convert';
import 'package:business_startup/configURL.dart';
import 'package:flutter/material.dart';
import 'package:business_startup/business/AvailabilityAdd.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<AvailabilityModel> fetchAvailability() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String tokenBusiness = (prefs.getString("tokenBusiness"));

  var url = ConfigURL.getApiBusinessinfoMe;

  Map<String, String> headers = {
    "Content-type": "application/json",
    "tokenBusiness": "$tokenBusiness",
  };
  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // AvailabilityModel.fromJson(json.decode(response.body));
    var data = AvailabilityModel.fromJson(json.decode(response.body));
    if (data.work1 != null) {
      await prefs.setBool("work1", data.work1);
    }
    try {
      return AvailabilityModel.fromJson(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  } else if (response.statusCode == 400) {
    // if return a 400 bad request response business has not setup a business profile yet
    // print(response.statusCode);
  } else {
    // If the server did not return a 200 OK response, or did return a 400 bad request response
    // then throw an exception.
    // throw Exception('Failed to load Availability');
  }
}

class AvailabilityModel {
  final bool work1;
  final String day_of_week1;
  final String start_time1;
  final String end_time1;
  final bool work2;
  final String day_of_week2;
  final String start_time2;
  final String end_time2;
  final bool work3;
  final String day_of_week3;
  final String start_time3;
  final String end_time3;
  final bool work4;
  final String day_of_week4;
  final String start_time4;
  final String end_time4;
  final bool work5;
  final String day_of_week5;
  final String start_time5;
  final String end_time5;
  final bool work6;
  final String day_of_week6;
  final String start_time6;
  final String end_time6;
  final bool work7;
  final String day_of_week7;
  final String start_time7;
  final String end_time7;

  AvailabilityModel({
    this.work1,
    this.day_of_week1,
    this.start_time1,
    this.end_time1,
    this.work2,
    this.day_of_week2,
    this.start_time2,
    this.end_time2,
    this.work3,
    this.day_of_week3,
    this.start_time3,
    this.end_time3,
    this.work4,
    this.day_of_week4,
    this.start_time4,
    this.end_time4,
    this.work5,
    this.day_of_week5,
    this.start_time5,
    this.end_time5,
    this.work6,
    this.day_of_week6,
    this.start_time6,
    this.end_time6,
    this.work7,
    this.day_of_week7,
    this.start_time7,
    this.end_time7,
  });

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) {
    // print(json["availability"]);
    // if json AvailabilityModel is null. display an empty AvailabilityModel
    if (json["availability"] == null) {
      return AvailabilityModel();
    }
    return AvailabilityModel(
      work1: json['availability']['work1'] as bool,
      day_of_week1: json['availability']['day_of_week1'] as String,
      start_time1: json['availability']['start_time1'] as String,
      end_time1: json['availability']['end_time1'] as String,
      work2: json['availability']['work2'] as bool,
      day_of_week2: json['availability']['day_of_week2'] as String,
      start_time2: json['availability']['start_time2'] as String,
      end_time2: json['availability']['end_time2'] as String,
      work3: json['availability']['work3'] as bool,
      day_of_week3: json['availability']['day_of_week3'] as String,
      start_time3: json['availability']['start_time3'] as String,
      end_time3: json['availability']['end_time3'] as String,
      work4: json['availability']['work4'] as bool,
      day_of_week4: json['availability']['day_of_week4'] as String,
      start_time4: json['availability']['start_time4'] as String,
      end_time4: json['availability']['end_time4'] as String,
      work5: json['availability']['work5'] as bool,
      day_of_week5: json['availability']['day_of_week5'] as String,
      start_time5: json['availability']['start_time5'] as String,
      end_time5: json['availability']['end_time5'] as String,
      work6: json['availability']['work6'] as bool,
      day_of_week6: json['availability']['day_of_week6'] as String,
      start_time6: json['availability']['start_time6'] as String,
      end_time6: json['availability']['end_time6'] as String,
      work7: json['availability']['work7'] as bool,
      day_of_week7: json['availability']['day_of_week7'] as String,
      start_time7: json['availability']['start_time7'] as String,
      end_time7: json['availability']['end_time7'] as String,
    );
  }
}

class AvailabilityBusiness extends StatefulWidget {
  static const String id = "availability";
  AvailabilityBusiness({Key key}) : super(key: key);

  @override
  _LocationBusinessState createState() => _LocationBusinessState();
}

class _LocationBusinessState extends State<AvailabilityBusiness> {
  Future<AvailabilityModel> futureLocation;

  @override
  void initState() {
    super.initState();
    futureLocation = fetchAvailability();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AvailabilityModel>(
      future: futureLocation,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          // print(data);
          // Parse all time from military time from database to american style am pm
          try {
            var d = "2020-01-01";
            var t = ":00:00";
            var ft = "00:00:00"; // ft = full time
            var start_time1Parse = data.work1 == true
                ? DateTime.parse("$d ${data.start_time1}$t")
                : DateTime.parse("$d $ft");
            var start_time1 = DateFormat.jm().format(start_time1Parse);

            var start_time2Parse = data.work2 == true
                ? DateTime.parse("$d ${data.start_time2}$t")
                : DateTime.parse("$d $ft");
            var start_time2 = DateFormat.jm().format(start_time2Parse);

            var start_time3Parse = data.work3 == true
                ? DateTime.parse("$d ${data.start_time3}$t")
                : DateTime.parse("$d $ft");
            var start_time3 = DateFormat.jm().format(start_time3Parse);

            var start_time4Parse = data.work4 == true
                ? DateTime.parse("$d ${data.start_time4}$t")
                : DateTime.parse("$d $ft");
            var start_time4 = DateFormat.jm().format(start_time4Parse);

            var start_time5Parse = data.work5 == true
                ? DateTime.parse("$d ${data.start_time5}$t")
                : DateTime.parse("$d $ft");
            var start_time5 = DateFormat.jm().format(start_time5Parse);

            var start_time6Parse = data.work6 == true
                ? DateTime.parse("$d ${data.start_time6}$t")
                : DateTime.parse("$d $ft");
            var start_time6 = DateFormat.jm().format(start_time6Parse);

            var start_time7Parse = data.work7 == true
                ? DateTime.parse("$d ${data.start_time7}$t")
                : DateTime.parse("$d $ft");
            var start_time7 = DateFormat.jm().format(start_time7Parse);

            var end_time1Parse = data.work1 == true
                ? DateTime.parse("$d ${data.end_time1}$t")
                : DateTime.parse("$d $ft");
            var end_time1 = DateFormat.jm().format(end_time1Parse);

            var end_time2Parse = data.work2 == true
                ? DateTime.parse("$d ${data.end_time2}$t")
                : DateTime.parse("$d $ft");
            var end_time2 = DateFormat.jm().format(end_time2Parse);

            var end_time3Parse = data.work3 == true
                ? DateTime.parse("$d ${data.end_time3}$t")
                : DateTime.parse("$d $ft");
            var end_time3 = DateFormat.jm().format(end_time3Parse);

            var end_time4Parse = data.work4 == true
                ? DateTime.parse("$d ${data.end_time4}$t")
                : DateTime.parse("$d $ft");
            var end_time4 = DateFormat.jm().format(end_time4Parse);

            var end_time5Parse = data.work5 == true
                ? DateTime.parse("$d ${data.end_time5}$t")
                : DateTime.parse("$d $ft");
            var end_time5 = DateFormat.jm().format(end_time5Parse);

            var end_time6Parse = data.work6 == true
                ? DateTime.parse("$d ${data.end_time6}$t")
                : DateTime.parse("$d $ft");
            var end_time6 = DateFormat.jm().format(end_time6Parse);

            var end_time7Parse = data.work7 == true
                ? DateTime.parse("$d ${data.end_time7}$t")
                : DateTime.parse("$d $ft");
            var end_time7 = DateFormat.jm().format(end_time7Parse);

            return Center(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.access_time),
                      title: Text("Availability"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Text(start_time1),
                        Text(
                          data.work1 == true
                              ? data.day_of_week1 + ": "
                              : "Monday: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.work1 == true
                              ? start_time1 + " - "
                              : "unavailable",
                        ),
                        Text(
                          data.work1 == true ? end_time1 : "",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          data.work2 == true
                              ? data.day_of_week2 + ": "
                              : "Tuesday: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.work2 == true
                              ? start_time2 + " - "
                              : "unavailable",
                        ),
                        Text(
                          data.work2 == true ? end_time2 : "",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          data.work3 == true
                              ? data.day_of_week3 + ": "
                              : "Wednesday:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.work3 == true
                              ? start_time3 + " - "
                              : " unavailable",
                        ),
                        Text(
                          data.work3 == true ? end_time3 : "",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          data.work4 == true
                              ? data.day_of_week4 + ": "
                              : "Thursday: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.work4 == true
                              ? start_time4 + " - "
                              : "unavailable",
                        ),
                        Text(
                          data.work4 == true ? end_time4 : "",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          data.work5 == true
                              ? data.day_of_week5 + ": "
                              : "Friday: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.work5 == true ? start_time5 + " - " : "",
                        ),
                        Text(
                          data.work5 == true ? end_time5 : "unavailable",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          data.work6 == true
                              ? data.day_of_week6 + ": "
                              : "Saturday: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.work6 == true
                              ? start_time6 + " - "
                              : "unavailable",
                        ),
                        Text(
                          data.work6 == true ? end_time6 : "",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          data.work7 == true
                              ? data.day_of_week7 + ": "
                              : "Sunday: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.work7 == true
                              ? start_time7 + " - "
                              : "unavailable",
                        ),
                        Text(
                          data.work7 == true ? end_time7 : "",
                        ),
                      ],
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('EDIT'),
                          onPressed: () {
                            // TODO: add a new screen for Availability Add thats takes data from the db to fill in previous data that user filled out before
                            Navigator.pushNamed(context, AvailabilityAdd.id);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } catch (e) {
            print(e);
          }
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
//        return CircularProgressIndicator();
        return Center(
          child: Card(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.access_time),
                    title: Text("Availability"),
                  ),
                  Center(child: const Text('Monday: ?')),
                  Center(child: const Text('Tuesday: ?')),
                  Center(child: const Text('Wednesday: ?')),
                  Center(child: const Text('Thursday: ?')),
                  Center(child: const Text('Friday: ?')),
                  Center(child: const Text('Saturday: ?')),
                  Center(child: const Text('Sunday: ?')),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('ADD AVAILABILITY'),
                        onPressed: () {
                          Navigator.pushNamed(context, AvailabilityAdd.id);
                        },
                      ),
                    ],
                  ),
                ]),
          ),
        );
      },
    );
  }
}
