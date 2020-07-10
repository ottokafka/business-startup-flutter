import 'dart:async';
import 'dart:convert';
import 'package:business_startup/configURL.dart';
import 'package:business_startup/user/CheckAvailability.dart';
import 'package:flutter/material.dart';
import 'package:business_startup/business/AvailabilityAdd.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as globals;
import 'week1.dart';
import 'week2.dart';
import 'week3.dart';

Future<AvailabilityModel> fetchAvailability() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = ConfigURL.getApiBusinessinfoTime;

  var body = jsonEncode(<String, dynamic>{
    "businessID": globals.businessID,
  });
  Map<String, String> headers = {
    "Content-type": "application/json",
  };

  final response =
      await http.get(url + "${globals.businessID}", headers: headers);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
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

class SearchBussinessInfo extends StatefulWidget {
  static const String id = "SearchBussinessInfo";

  SearchBussinessInfo({Key key}) : super(key: key);

  @override
  _SearchBussinessInfoState createState() => _SearchBussinessInfoState();
}

class _SearchBussinessInfoState extends State<SearchBussinessInfo> {
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
          var day = DateTime.daysPerWeek;
          var weekday = DateTime.now().weekday;

          print(day);
          var dayOfWeek = DateFormat.EEEE().format(DateTime.parse(
              DateTime.parse(DateTime.now().toString()).toString()));
          print(dayOfWeek);
          // Parse all time from military time from database to american style am pm
          try {
            var start_time1Parse = data.work1 == true
                ? DateTime.parse("2020-01-01 ${data.start_time1}:00:00")
                : DateTime.parse("2020-01-01 00:00:00");
            var start_time1 = DateFormat.jm().format(start_time1Parse);
            var start_time2Parse = data.work2 == true
                ? DateTime.parse("2020-01-01 ${data.start_time2}:00:00")
                : DateTime.parse("2020-01-01 00:00:00");
            var start_time2 = DateFormat.jm().format(start_time2Parse);
            var start_time3Parse = data.work3 == true
                ? DateTime.parse("2020-01-01 ${data.start_time3}:00:00")
                : DateTime.parse("2020-01-01 00:00:00");
            var start_time3 = DateFormat.jm().format(start_time3Parse);
            var start_time4Parse = data.work4 == true
                ? DateTime.parse("2020-01-01 ${data.start_time4}:00:00")
                : DateTime.parse("2020-01-01 00:00:00");
            var start_time4 = DateFormat.jm().format(start_time4Parse);
            var start_time5Parse = data.work5 == true
                ? DateTime.parse("2020-01-01 ${data.start_time5}:00:00")
                : DateTime.parse("2020-01-01 00:00:00");
            var start_time5 = DateFormat.jm().format(start_time5Parse);
            var start_time6Parse = data.work6 == true
                ? DateTime.parse("2020-01-01 ${data.start_time6}:00:00")
                : DateTime.parse("2020-01-01 00:00:00");
            var start_time6 = DateFormat.jm().format(start_time6Parse);
            var start_time7Parse = data.work7 == true
                ? DateTime.parse("2020-01-01 ${data.start_time7}:00:00")
                : DateTime.parse("2020-01-01 00:00:00");
            var start_time7 = DateFormat.jm().format(start_time7Parse);

            var end_time1Parse = data.work1 == true
                ? DateTime.parse("2020-01-01 ${data.end_time1}:00:00")
                : DateTime.parse("2020-01-01 00:00:00");
            var end_time1 = DateFormat.jm().format(end_time1Parse);
            var end_time2Parse = data.work2 == true
                ? DateTime.parse("2020-01-01 ${data.end_time2}:00:00")
                : DateTime.parse("2020-01-01 00:00:00");
            var end_time2 = DateFormat.jm().format(end_time2Parse);
            var end_time3Parse = data.work3 == true
                ? DateTime.parse("2020-01-01 ${data.end_time3}:00:00")
                : DateTime.parse("2020-01-01 00:00:00");
            var end_time3 = DateFormat.jm().format(end_time3Parse);
            var end_time4Parse = data.work4 == true
                ? DateTime.parse("2020-01-01 ${data.end_time4}:00:00")
                : DateTime.parse("2020-01-01 00:00:00");
            var end_time4 = DateFormat.jm().format(end_time4Parse);
            var end_time5Parse = data.work5 == true
                ? DateTime.parse("2020-01-01 ${data.end_time5}:00:00")
                : DateTime.parse("2020-01-01 00:00:00");
            var end_time5 = DateFormat.jm().format(end_time5Parse);
            var end_time6Parse = data.work6 == true
                ? DateTime.parse("2020-01-01 ${data.end_time6}:00:00")
                : DateTime.parse("2020-01-01 00:00:00");
            var end_time6 = DateFormat.jm().format(end_time6Parse);
            var end_time7Parse = data.work7 == true
                ? DateTime.parse("2020-01-01 ${data.end_time7}:00:00")
                : DateTime.parse("2020-01-01 00:00:00");
            var end_time7 = DateFormat.jm().format(end_time7Parse);

            var monday2sunday1 = Text(
                "This Week ${DateFormat.Md().format(DateTime.parse(monday()))} - ${DateFormat.Md().format(DateTime.parse(sunday()))}");

            var monday2sunday2 = Text(
                "Next Week ${DateFormat.Md().format(DateTime.parse(monday2()))} - ${DateFormat.Md().format(DateTime.parse(sunday2()))}");
            var monday2sunday3 = Text(
                "2nd Week ${DateFormat.Md().format(DateTime.parse(monday3()))} - ${DateFormat.Md().format(DateTime.parse(sunday3()))}");

            return Scaffold(
              appBar: AppBar(
                title: Text("🏢Business"),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              leading: Icon(Icons.access_time),
                              title: Text("This Weeks Availability"),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work1 == true && DateTime.monday >= weekday
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          // Navigator.push(
                                          //     context, CheckAvailability.id);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: monday(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Monday: $start_time1 - $end_time1"),
                                      )
                                    : Text("Monday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work2 == true &&
                                        DateTime.tuesday >= weekday
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: tuesday(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Tuesday: $start_time2 - $end_time2"),
                                      )
                                    : Text("Tuesday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work3 == true &&
                                        DateTime.wednesday >= weekday
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: wednesday(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Wednesday: $start_time3 - $end_time3"),
                                      )
                                    : Text("Wednesday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work4 == true &&
                                        DateTime.thursday >= weekday
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: thursday(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Thursday: $start_time4 - $end_time4"),
                                      )
                                    : Text("Thursday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work5 == true && DateTime.friday >= weekday
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: friday(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Friday: $start_time5 - $end_time5"),
                                      )
                                    : Text("Friday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work6 == true &&
                                        DateTime.saturday >= weekday
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: saturday(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Saturday: $start_time6 - $end_time6"),
                                      )
                                    : Text("Saturday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work7 == true && DateTime.sunday >= weekday
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: sunday(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Sunday: $start_time7 - $end_time7"),
                                      )
                                    : Text("Sunday: unavailable")
                              ],
                            ),
                            ButtonBar(
                              children: <Widget>[
                                FlatButton(
                                  child: const Text(''),
                                  onPressed: () {
                                    // TODO: add a new screen for Availability Add thats takes data from the db to fill in previous data that user filled out before
                                    // Navigator.pushNamed(context, AvailabilityAdd.id);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ), // card 1
                      Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.access_time),
                              title: monday2sunday2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work1 == true
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          // Navigator.push(
                                          //     context, CheckAvailability.id);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: monday2(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Monday: $start_time1 - $end_time1"),
                                      )
                                    : Text("Monday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work2 == true
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: tuesday2(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Tuesday: $start_time2 - $end_time2"),
                                      )
                                    : Text("Tuesday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work3 == true
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: wednesday2(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Wednesday: $start_time3 - $end_time3"),
                                      )
                                    : Text("Wednesday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work4 == true
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: thursday2(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Thursday: $start_time4 - $end_time4"),
                                      )
                                    : Text("Thursday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work5 == true
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: friday2(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Friday: $start_time5 - $end_time5"),
                                      )
                                    : Text("Friday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work6 == true
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: saturday2(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Saturday: $start_time6 - $end_time6"),
                                      )
                                    : Text("Saturday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work7 == true
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: sunday2(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Sunday: $start_time7 - $end_time7"),
                                      )
                                    : Text("Sunday: unavailable")
                              ],
                            ),
                            ButtonBar(
                              children: <Widget>[
                                FlatButton(
                                  child: const Text(''),
                                  onPressed: () {
                                    // TODO: add a new screen for Availability Add thats takes data from the db to fill in previous data that user filled out before
                                    // Navigator.pushNamed(context, AvailabilityAdd.id);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ), // End of Card 2
                      Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.access_time),
                              title: monday2sunday3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work1 == true
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          // Navigator.push(
                                          //     context, CheckAvailability.id);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: monday3(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Monday: $start_time1 - $end_time1"),
                                      )
                                    : Text("Monday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work2 == true
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: tuesday3(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Tuesday: $start_time2 - $end_time2"),
                                      )
                                    : Text("Tuesday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work3 == true
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: wednesday3(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Wednesday: $start_time3 - $end_time3"),
                                      )
                                    : Text("Wednesday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work4 == true
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: thursday3(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Thursday: $start_time4 - $end_time4"),
                                      )
                                    : Text("Thursday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work5 == true
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: friday3(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Friday: $start_time5 - $end_time5"),
                                      )
                                    : Text("Friday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work6 == true
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: saturday3(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Saturday: $start_time6 - $end_time6"),
                                      )
                                    : Text("Saturday: unavailable")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                data.work7 == true
                                    ? FlatButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckAvailability(
                                                  date: sunday3(),
                                                ),
                                              ));
                                        },
                                        icon: Icon(Icons.calendar_today),
                                        label: Text(
                                            "Sunday: $start_time7 - $end_time7"),
                                      )
                                    : Text("Sunday: unavailable")
                              ],
                            ),
                            ButtonBar(
                              children: <Widget>[
                                FlatButton(
                                  child: const Text(''),
                                  onPressed: () {
                                    // TODO: add a new screen for Availability Add thats takes data from the db to fill in previous data that user filled out before
                                    // Navigator.pushNamed(context, AvailabilityAdd.id);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ), // Card 3
                    ],
                  ),
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
        return CircularProgressIndicator();
        // return Container(child: Text("no data"));
      },
    );
  }
}
