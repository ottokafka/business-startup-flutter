import 'package:business_startup/configURL.dart';
import 'package:business_startup/user/Chat.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BottomNavigationBusiness.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'acceptBookingAction.dart';
import '../globals.dart' as globals;

Future<List<Photo>> fetchPhotos(http.Client client) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String tokenBusiness = (prefs.getString("tokenBusiness"));

  Map<String, String> headers = {
    "Content-type": "application/json",
    "tokenBusiness": "$tokenBusiness",
  };
  var url = ConfigURL.getApiAppointmentsBusiness;

  final response = await client.get(url, headers: headers);
  // print(response.body);
  client.close();
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print("length");
  print(parsed.length);
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String time;
  final String date;
  final String user;
  final String userName;
  final String userID;
  final bool accept;

  Photo(
      {this.time,
      this.date,
      this.user,
      this.userName,
      this.userID,
      this.accept});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        time: json['time'],
        date: json['date'],
        user: json['user'],
        userName: json['userName'],
        userID: json['user'],
        accept: json['accept']);
  }
}

class AppointmentsBusiness extends StatelessWidget {
  static const String id = 'AppointmentsBusiness';

  AppointmentsBusiness({Key key}) : super(key: key);

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
      bottomNavigationBar: BottomNavigationBusiness(),
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
        DateTime now = DateTime.parse(DateTime.now().toString());

        var ymd = DateFormat.yMd().format(DateTime.parse(data.date == null
            ? "0000-00-00 00:00:00"
            : "${data.date} ${data.time}"));

        String bookDate1 = data.date == null
            ? "0000-00-00 00:00:00"
            : "${data.date} ${data.time}";
        // String dataDate = "${data.date} ${data.time}";

        var tDate = int.parse(DateFormat.d().format(now));
        var tMonth = int.parse(DateFormat.M().format(now));
        var tYear = int.parse(DateFormat.y().format(now));

        var bYear = int.parse(DateFormat.y().format(DateTime.parse(bookDate1)));
        var bMonth =
            int.parse(DateFormat.M().format(DateTime.parse(bookDate1)));
        var bDate = int.parse(DateFormat.d().format(DateTime.parse(bookDate1)));

        var dayOfWeek = DateFormat.EEEE().format(DateTime.parse(bookDate1));
        print(dayOfWeek);

        var time = DateFormat.jm().format(DateTime.parse(bookDate1));

        print("$tDate $bDate");
        if (tDate <= bDate && tMonth <= bMonth && tYear <= bYear) {
          print(
              "todate is less then book date and this month is less or equal to booed month");
          print("$tDate $bDate $tMonth $bMonth $tYear $bYear");
        }

        // var tDate = int.parse(today);
        // var bDate = int.parse(booking);
        // print(data.date);
        // print(time);
        // print(data.time);
        if (data.time != null) {
          return Card(
            child: InkWell(
              onTap: () async {
                if (data.time == null) {
                  print("no appointments to confirm");
                  return "";
                }
                if (data.accept == true) {
                  print("Barber already accepted appointment");
                  return '';
                }
                if (tDate <= bDate && tMonth <= bMonth && tYear <= bYear) {
                  await Alert(
                    context: context,
                    type: AlertType.info,
                    title: "Accept Appointment?",
                    desc: "${data.time}",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "No",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () async {
                          var accept = false;
                          // print(data.user);
                          // print(data.time);

                          await acceptBooking(
                              data.user, accept, data.time, data.date);
                          // Navigator.pop(context);
                          Navigator.pushNamed(context, AppointmentsBusiness.id);
                        },
                        color: Colors.black,
                      ),
                      DialogButton(
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Colors.green,
                        onPressed: () async {
                          var accept = true;
                          await acceptBooking(
                              data.user, accept, data.time, data.date);
                          // Navigator.pop(context);
                          Navigator.pushNamed(context, AppointmentsBusiness.id);
                        },
                      )
                    ],
                  ).show();
                } else {
                  print("Time is past, connot confrim appointment");
                  Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "BOOKING EXPIRED",
                    desc: "This booking expired on $ymd",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        width: 120,
                      )
                    ],
                  ).show();
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    // leading: Icon(Icons.access_time),

                    title: Center(
                      child: Text(
                        data.userName == null ? "" : "👨 ${data.userName}",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // title: Text(
                    //   data.time == null ? "NO APPOINTMENTS" : time,
                    //   style: TextStyle(
                    //       color: Colors.black, fontWeight: FontWeight.bold),
                    // ),
                    subtitle: data.date == null
                        ? Text("")
                        : tDate <= bDate && tMonth <= bMonth && tYear <= bYear
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("$dayOfWeek "),
                                  // Text(
                                  //   "TODAY ",
                                  //   style: TextStyle(
                                  //       color: Colors.green,
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                  Text(
                                    time,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            : Center(
                                child: Text("EXPIRED",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold)),
                              ),
                  ),
                  Text(ymd),
                  Row(
                    children: <Widget>[
                      data.accept == true &&
                              tDate <= bDate &&
                              tMonth <= bMonth &&
                              tYear <= bYear
                          ? FlatButton.icon(
                              onPressed: () {
                                globals.userID = data.userID;
                                globals.userName = data.userName;
                                // print(data.userID);
                                Navigator.pushNamed(context, Chat.id);
                              },
                              icon: Icon(Icons.message),
                              label: Text("Chat"))
                          : Text(""),
                    ],
                  ),
                  data.accept == null &&
                          tDate <= bDate &&
                          tMonth <= bMonth &&
                          tYear <= bYear
                      ? Text("TOUCH TO ACCEPT")
                      : data.accept == true
                          ? Text("✅",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10))
                          : Text("REJECTED",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 11)),
                  data.accept == null
                      ? Text(
                          "NOT CONFIRMED",
                          style: TextStyle(color: Colors.red, fontSize: 9),
                        )
                      : data.accept == true
                          ? Text(
                              "BOOKING ACCEPTED",
                              style: TextStyle(
                                  color: Colors.green[500], fontSize: 9),
                            )
                          : Text(
                              "BOOKING REJECTED",
                              style: TextStyle(
                                  color: Colors.red[300], fontSize: 9),
                            ),
                ],
              ),
            ),
          );
        } else {
          // ------------  NO APPOITNMENTS ------------------------
          return Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.timer),
                    title: Text('No Appointments',
                        style: TextStyle(color: Colors.red, fontSize: 13)),
                    subtitle: Text(
                        'No appointments have been booked by clients yet',
                        style: TextStyle(color: Colors.black, fontSize: 11)),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('WHY'),
                        onPressed: () {
                          Alert(
                            context: context,
                            type: AlertType.info,
                            title: "Why no appointments",
                            desc:
                                "Clients will find you by searching your location or name. Make sure your address is correct. If everything is done just wait patiently.",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                              )
                            ],
                          ).show();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
