import 'dart:async';
import 'dart:convert';
import 'package:business_startup/configURL.dart';
import 'package:business_startup/user/SearchBusinessInfo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'CheckAvailability.dart';
import '../globals.dart' as globals;

Future<List<Locations>> fetchBusinesses(http.Client client) async {
  var url = ConfigURL.postApiBusinessinfoCity;
//   var url = 'http://127.0.0.1:5000/api/businessinfo/city';
// //  var url = 'http://10.0.2.2:5000/api/businessinfo/city';
  final response = await client.get(url);
  print(response.body);
  // Must close the conntection otherwise connection stay open waiting resources
  client.close();
  // Use the compute function to run parseLocations in a separate isolate.
  try {
    return compute(parseLocations, response.body);
  } catch (e) {
    print(e);
  }
}

// A function that converts a response body into a List<Locations>.
List<Locations> parseLocations(String responseBody) {
  try {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    // print(parsed);
    return parsed.map<Locations>((json) => Locations.fromJson(json)).toList();
  } catch (e) {
    print(e);
  }
}

class Locations {
  final String distance;
  final String company;
  final String address;
  final String city;
  final String state;
  final int zip;
  final String businessid;
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

  Locations({
    this.distance,
    this.company,
    this.address,
    this.city,
    this.state,
    this.zip,
    this.businessid,
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

  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(
      distance: json['location']['distance'] as String,
      company: json['company'] as String,
      businessid: json['business'] as String,
      address: json['location']['address'] as String,
      city: json['location']['city'] as String,
      state: json['location']['state'] as String,
      zip: json['location']['zip'] as int,
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

class MyDate {
  final String myDate;

  MyDate({this.myDate});
}

class SearchResults extends StatelessWidget {
  static const String id = 'SearchResults';

  SearchResults({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<Locations>>(
        future: fetchBusinesses(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? BusinessesList(businesses: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class BusinessesList extends StatelessWidget {
  final List<Locations> businesses;

  BusinessesList({Key key, this.businesses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: businesses.length,
      itemBuilder: (context, index) {
        var data = businesses[index];
        if (data.work1 == true) {}
        DateTime date = DateTime.now();
        var today = date.weekday;
        // -------- Change all times to American style ---------------
        var start_time1 = data.work1 == true
            ? DateFormat.jm()
                .format(DateTime.parse("0000-00-00 ${data.start_time1}:00:00"))
            : null;
        var end_time1 = data.work1 == true
            ? DateFormat.jm()
                .format(DateTime.parse("0000-00-00 ${data.end_time1}:00:00"))
            : null;
        var start_time2 = data.work2 == true
            ? DateFormat.jm()
                .format(DateTime.parse("0000-00-00 ${data.start_time2}:00:00"))
            : null;
        var end_time2 = data.work2 == true
            ? DateFormat.jm()
                .format(DateTime.parse("0000-00-00 ${data.end_time2}:00:00"))
            : null;
        var start_time3 = data.work3 == true
            ? DateFormat.jm()
                .format(DateTime.parse("0000-00-00 ${data.start_time3}:00:00"))
            : null;
        var end_time3 = data.work3 == true
            ? DateFormat.jm()
                .format(DateTime.parse("0000-00-00 ${data.end_time3}:00:00"))
            : null;
        var start_time4 = data.work4 == true
            ? DateFormat.jm()
                .format(DateTime.parse("0000-00-00 ${data.start_time4}:00:00"))
            : null;
        var end_time4 = data.work4 == true
            ? DateFormat.jm()
                .format(DateTime.parse("0000-00-00 ${data.end_time4}:00:00"))
            : null;
        var start_time5 = data.work5 == true
            ? DateFormat.jm()
                .format(DateTime.parse("0000-00-00 ${data.start_time5}:00:00"))
            : null;
        var end_time5 = data.work5 == true
            ? DateFormat.jm()
                .format(DateTime.parse("0000-00-00 ${data.end_time5}:00:00"))
            : null;
        var start_time6 = data.work6 == true
            ? DateFormat.jm()
                .format(DateTime.parse("0000-00-00 ${data.start_time6}:00:00"))
            : null;
        var end_time6 = data.work6 == true
            ? DateFormat.jm()
                .format(DateTime.parse("0000-00-00 ${data.end_time6}:00:00"))
            : null;
        var start_time7 = data.work7 == true
            ? DateFormat.jm()
                .format(DateTime.parse("0000-00-00 ${data.start_time7}:00:00"))
            : null;
        var end_time7 = data.work7 == true
            ? DateFormat.jm()
                .format(DateTime.parse("0000-00-00 ${data.end_time7}:00:00"))
            : null;

        // print("$startTime-$endTime");
        return Card(
          child: InkWell(
            onTap: () async {
              if (data.work1 == false ||
                  data.work2 == false ||
                  data.work3 == false ||
                  data.work4 == false ||
                  data.work5 == false ||
                  data.work6 == false ||
                  data.work7 == false) {
                //TODO: if not open. then open a new screen showing all business info and availability
                //TODO: allow user to click a day and book a available time
                print(businesses[index].businessid);
                globals.businessID = businesses[index].businessid;
                Navigator.pushNamed(context, SearchBussinessInfo.id);
                print("Not Open Today");
              } else {
                print(businesses[index].businessid);

// Here I'm using seting a global variable to hold a business ID
                globals.businessID = businesses[index].businessid;
                globals.company = businesses[index].company;
                globals.address = businesses[index].address;
                globals.city = businesses[index].city;
                globals.state = businesses[index].state;

                // Navigator.pushNamed(context, CheckAvailability.id);
                Navigator.pushNamed(context, SearchBussinessInfo.id);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Text('🏢${businesses[index].company}'),
                // TODO: here we will use the address to open up a link to maps
                Row(
                  children: <Widget>[
                    Text("${businesses[index].distance}"),
                    Text(
                      "🏢",
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      "${businesses[index].company}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.place),
                    Text(businesses[index].address)
                  ],
                ),

                //TODO: Show the current day
                SizedBox(height: 10),
                Text(
                  "Open Today?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(today == 1 && data.work1 == true
                    ? 'Mon: ${start_time1}-${end_time1}'
                    : today == 2 && data.work2 == true
                        ? 'Tues: ${start_time2}-${end_time2}'
                        : today == 3 && data.work3 == true
                            ? 'Wed: ${start_time3}-${end_time3}'
                            : today == 4 && data.work4 == true
                                ? 'Thur: ${start_time4}-${end_time4}'
                                : today == 5 && data.work5 == true
                                    ? 'Fri: ${start_time5}-${end_time5}'
                                    : today == 6 && data.work6 == true
                                        ? 'Sat: ${start_time6}-${end_time6}'
                                        : today == 7 && data.work7 == true
                                            ? 'Sun: ${start_time7}-${end_time7}'
                                            : "Not Open Today"),
                SizedBox(height: 20),
                Text("TOUCH TO BOOK",
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
        );
      },
    );
  }
}
