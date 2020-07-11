import 'package:business_startup/configURL.dart';
import 'package:business_startup/user/Chat.dart';
import 'package:business_startup/user/Search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BottomNavigationUser.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';

Future<List<Photo>> fetchPhotos(http.Client client) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String tokenUser = (prefs.getString("tokenUser"));
  var url = ConfigURL.getApiAppointments;

  Map<String, String> headers = {
    "Content-type": "application/json",
    "tokenUser": "$tokenUser",
  };
  final response = await client.get(url, headers: headers);
  // print(response.body);
  client.close();
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String company;
  final String address;
  final String city;
  final String state;
  final String time;
  final String date;
  final bool accept;
  final String businessID;

  Photo(
      {this.company,
      this.address,
      this.city,
      this.state,
      this.time,
      this.date,
      this.accept,
      this.businessID});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
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

class AppointmentUser extends StatelessWidget {
  static const String id = 'AppointmentUser';

  AppointmentUser({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Appointments"),
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(bookings: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BottomNavigationUser(),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Photo> bookings;

  PhotosList({Key key, this.bookings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        var data = bookings[index];

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

          var dayOfWeek = DateFormat.EEEE().format(DateTime.parse(bookDate1));
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
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "",
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        data.company == null ? "" : "${data.company}",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                data.date == null
                    ? Text("")
                    : tDate <= bDate && tMonth <= bMonth && tYear <= bYear
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("$dayOfWeek "),
                              Text(data.time == null ? "" : time,
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          )
                        : Text("EXPIRED",
                            style: TextStyle(color: Colors.red, fontSize: 30)),
                Text("$bookDate "),
                tDate <= bDate && tMonth <= bMonth && tYear <= bYear
                    ? Row(
                        children: <Widget>[
                          data.accept == true &&
                                  tDate <= bDate &&
                                  tMonth <= bMonth &&
                                  tYear <= bYear
                              ? FlatButton.icon(
                                  onPressed: () {
                                    globals.businessID = data.businessID;
                                    globals.company = data.company;
                                    print(globals.company);
                                    Navigator.pushNamed(context, Chat.id);
                                  },
                                  icon: Icon(Icons.message),
                                  label: Text("Chat"),
                                )
                              : FlatButton(onPressed: null, child: null),
                          FlatButton.icon(
                              // color: Colors.black,
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
                                // color: Colors.white,
                              ),
                              label: Text(
                                data.address == null ? "" : "Maps",
                                // style: TextStyle(color: Colors.white),
                              )),
                        ],
                      )
                    : Text(""),

                // SizedBox(height: 5),

                data.time != null &&
                        data.accept == null &&
                        tDate <= bDate &&
                        tMonth <= bMonth &&
                        tYear <= bYear
                    ? Text("")
                    : Text(""),
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

        // By default, show a loading spinner.
        // return CircularProgressIndicator();
      },
    );
  }
}
