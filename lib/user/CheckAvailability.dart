import 'dart:async';
import 'dart:convert';
import 'package:business_startup/configURL.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppointmentUser.dart';
import 'createAppointment.dart';
import '../globals.dart' as globals;
import 'package:rflutter_alert/rflutter_alert.dart';

var userName;
getName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name");
  userName = name;
}

Future<Times> fetchAvailability(businessid) async {
  var url = "${ConfigURL.getApiCheckAvailability}$businessid";
  // var url = "http://127.0.0.1:5000/api/checkAvailability/$businessid";

  final response = await http.get(url);
  // print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Times.fromJson(json.decode(response.body));
  }
  if (response.statusCode == 401) {
  } else {}
  {
    // TODO: add logic to deal with a date thats no available for example if tuesday is not available then it return nothing not good! we need to grab the next day then.
    // If the server did not return a 200 OK response,
    // then throw an exception.
    // throw Exception('Failed to load album');
  }
}

class Times {
  final List from;

  Times({this.from});

  factory Times.fromJson(Map<String, dynamic> json) {
    return Times(
      from: json['timeSlots']['from'] as List,
    );
  }
}

class CheckAvailability extends StatefulWidget {
  static const String id = 'CheckAvailability';
  final String date;
  CheckAvailability({Key key, this.date}) : super(key: key);

  @override
  _CheckAvailabilityState createState() => _CheckAvailabilityState();
}

class _CheckAvailabilityState extends State<CheckAvailability> {
  Future<Times> futureAlbum;
  var newDate;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAvailability(globals.businessID);
    // getName();
    getDate(widget.date);
  }

  void getDate(String date) {
    newDate = date;
    print(newDate);
  }

  @override
  Widget build(BuildContext context) {
    String day = DateFormat.EEEE().format(DateTime.parse(newDate));
    String selectedDate =
        DateFormat.MMMMEEEEd().format(DateTime.parse(newDate));

    return Scaffold(
      appBar: AppBar(
        title: Text(globals.company != ""
            ? "${globals.company} - Availability"
            : "Business availability"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: FutureBuilder<Times>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              // If length is zero Business is not open
              if (data.from.length == 0) {
                print("zero no appointments");
                return Text("Not open today");
              }
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      selectedDate,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 2.1,
                      ),
                      itemCount: data.from.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: InkWell(
                            onTap: () async {
                              var bookTime = DateFormat.jm().format(
                                  DateTime.parse(
                                      "0000-00-00 ${data.from[index]}:00"));
                              await Alert(
                                context: context,
                                type: AlertType.info,
                                title: "Book Appointment",
                                desc: "${bookTime}",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "No",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    color: Colors.black,
                                  ),
                                  DialogButton(
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    color: Colors.green,
                                    onPressed: () async {
                                      await getName();

                                      await addAppointment(
                                        data.from[index],
                                        globals.businessID,
                                        userName,
                                        globals.company,
                                        globals.address,
                                        globals.city,
                                        globals.state,
                                        newDate,
                                      );

                                      await Alert(
                                        context: context,
                                        type: AlertType.success,
                                        title: "Successfuly Booked",
                                        desc: "Appointment time: ${bookTime}",
                                        buttons: [
                                          DialogButton(
                                            child: Text(
                                              "COOL",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            width: 120,
                                          )
                                        ],
                                      ).show();

                                      Navigator.pushNamed(
                                          context, AppointmentUser.id);
                                    },
                                  )
                                ],
                              ).show();
                              print(data.from[index]);
                            },
                            child: Column(
                              children: <Widget>[
                                // Text(data.from[index]),
                                Text(DateFormat.jm()
                                    .format(DateTime.parse(
                                        "0000-00-00 ${data.from[index]}:00"))
                                    .toString()),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
