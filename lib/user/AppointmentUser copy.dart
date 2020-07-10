import 'package:business_startup/configURL.dart';
import 'package:business_startup/user/Chat.dart';
import 'package:business_startup/user/Search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BottomNavigationUser.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';

Future<Album> fetchAlbum() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String tokenUser = (prefs.getString("tokenUser"));

  var url = ConfigURL.getApiAppointments;
  // var url = "http://127.0.0.1:5000/api/appointments";

  Map<String, String> headers = {
    "Content-type": "application/json",
    "tokenUser": "$tokenUser",
  };
  final response = await http.get(url, headers: headers);

  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    // throw Exception('Failed to load album');
  }
}

class Album {
  final String company;
  final String address;
  final String city;
  final String state;
  final String time;
  final String date;
  final bool accept;
  final String businessID;

  Album(
      {this.company,
      this.address,
      this.city,
      this.state,
      this.time,
      this.date,
      this.accept,
      this.businessID});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        company: json['company'],
        address: json['address'],
        city: json['city'],
        state: json['state'],
        time: json['time'],
        date: json['date'],
        accept: json['accept'],
        businessID: json['business']);
  }
}

class AppointmentUser extends StatefulWidget {
  static const String id = "AppointmentUser";

  AppointmentUser({Key key}) : super(key: key);

  @override
  _AppointmentUserState createState() => _AppointmentUserState();
}

class _AppointmentUserState extends State<AppointmentUser> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(
        //   color: Colors.transparent,
        // ),
        title: Text('Appointments'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            var data = snapshot.data;
            print(data);
            if (snapshot.hasData) {
              if (data.time != null) {
                DateTime now = DateTime.parse(DateTime.now().toString());

                var bookDate = DateFormat.yMd().format(DateTime.parse(
                    data.date == null
                        ? "0000-00-00 00:00:00"
                        : "${data.date} ${data.time}"));

                String bookDate1 = data.date == null
                    ? "0000-00-00 00:00:00"
                    : "${data.date} ${data.time}";
                // String dataDate = "${data.date} ${data.time}";

                var tDate = int.parse(DateFormat.d().format(now));
                var tMonth = int.parse(DateFormat.M().format(now));
                var tYear = int.parse(DateFormat.y().format(now));

                var bYear =
                    int.parse(DateFormat.y().format(DateTime.parse(bookDate1)));
                var bMonth =
                    int.parse(DateFormat.M().format(DateTime.parse(bookDate1)));
                var bDate =
                    int.parse(DateFormat.d().format(DateTime.parse(bookDate1)));

                var dayOfWeek =
                    DateFormat.EEEE().format(DateTime.parse(bookDate1));
                print(dayOfWeek);

                var time = DateFormat.jm().format(DateTime.parse(bookDate1));

                print("$tDate $bDate");
                if (tDate <= bDate && tMonth <= bMonth && tYear <= bYear) {
                  print(
                      "todate is less then book date and this month is less or equal to booed month");
                  print("$tDate $bDate $tMonth $bMonth $tYear $bYear");
                }

                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.access_time),
                        title: Text("Appointment"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "🏢",
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                            data.company == null ? "" : "${data.company}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      data.date == null
                          ? Text("")
                          : tDate <= bDate && tMonth <= bMonth && tYear <= bYear
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("$dayOfWeek "),
                                    // Text("TODAY ",
                                    //     style: TextStyle(
                                    //         color: Colors.green,
                                    //         fontWeight: FontWeight.bold)),
                                    Text(data.time == null ? "" : time,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ],
                                )
                              : Text("EXPIRED",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 30)),
                      tDate <= bDate && tMonth <= bMonth && tYear <= bYear
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FlatButton.icon(
                                  color: Colors.black,
                                  onPressed: () {
                                    if (data.time != null &&
                                        data.accept == true) {
                                      globals.businessID = data.businessID;
                                      globals.company = data.company;
                                      print(globals.company);
                                      Navigator.pushNamed(context, Chat.id);
                                    }
                                  },
                                  icon: data.time != null && data.accept == true
                                      ? Icon(
                                          Icons.message,
                                          color: Colors.white,
                                        )
                                      : Icon(Icons.timer),
                                  label: Text("CHAT",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Text(" OR "),
                                // -------------------- GOOGLE MAP SEARCH -----------------
                                FlatButton.icon(
                                    color: Colors.black,
                                    onPressed: () async {
                                      // TODO: search map for address and city
                                      // EXAMPLE google map url search: https://www.google.com/maps/place/1st+Ave,+Sacramento,+CA,+USA/
                                      var url =
                                          'https://www.google.com/maps/place/${data.address}+${data.city}+${data.state}+USA/';
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    icon: Icon(
                                      Icons.add_location,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      data.address == null ? "" : "MAPS",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ],
                            )
                          : Text(""),
                      SizedBox(height: 10),
                      Text("✅", style: TextStyle(fontSize: 9)),
                      Text(
                        data.time == null
                            ? "You didn't book any appointments today"
                            : data.time != null && data.accept == true
                                ? "ACCEPTED"
                                : data.time != null && data.accept == false
                                    ? "Appointment rejected"
                                    : data.time != null && data.accept == null
                                        ? "Waiting for barber ..."
                                        : "",
                        style: TextStyle(fontSize: 9),
                      ),
                      data.time != null &&
                              data.accept == null &&
                              tDate <= bDate &&
                              tMonth <= bMonth &&
                              tYear <= bYear
                          ? CircularProgressIndicator()
                          : Text(""),
                    ],
                  ),
                );
              } else {
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.access_time),
                        title: Text("No Appointment Today 😭"),
                      ),
                      Text("You dont have any appointments today。"),
                      Text("Search for a barber and book。"),
                      SizedBox(height: 20),
                      FlatButton.icon(
                          color: Colors.black,
                          onPressed: () {
                            Navigator.pushNamed(context, Search.id);
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Search",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationUser(),
    );
  }
}
