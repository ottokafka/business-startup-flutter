import 'dart:async';
import 'dart:convert';
import 'package:business_startup/configURL.dart';
import 'package:flutter/material.dart';
import 'package:business_startup/business/LocationAdd.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyDataModel {
  String company;
  String address;
  String city;
  String businessID;
  bool work1;
  getLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    company = prefs.getString("company");
    address = prefs.getString("address");
    city = prefs.getString("city");
    businessID = prefs.getString("businessID");
    work1 = prefs.getBool("work1");
  }

  var jsonResponse;
  Future<Location> fetchLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenBusiness = (prefs.getString("tokenBusiness"));
    company = prefs.getString("company");
    var url = ConfigURL.getApiBusinessinfoMe;

    Map<String, String> headers = {
      "Content-type": "application/json",
      "tokenBusiness": "$tokenBusiness",
    };
    final response = await http.get(url, headers: headers);
    jsonResponse = response.body;
    if (response.statusCode == 200) {
      return Location.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
    } else {}
  }
}

Future<Location> fetchLocation() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String tokenBusiness = (prefs.getString("tokenBusiness"));

  // var url = 'http://127.0.0.1:5000/api/businessinfo/me';
  var url = ConfigURL.getApiBusinessinfoMe;
//  var url = 'http://10.0.2.2:5000/api/businessinfo/me';
//  var url = 'https://startup-barber.herokuapp.com/api/businessinfo/me';;
  Map<String, String> headers = {
    "Content-type": "application/json",
    "tokenBusiness": "$tokenBusiness",
  };
  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    try {
      return Location.fromJson(json.decode(response.body));
    } catch (e) {
      print(e);
    }
  } else if (response.statusCode == 400) {
    // if return a 400 bad request response business has not setup a business profile yet
    // print(response.statusCode);
  } else {
    // If the server did not return a 200 OK response, or did return a 400 bad request response
    // then throw an exception.
    // throw Exception('Failed to load Location');
  }
}

//TODO: This is the model that need to be wrapped in a change notifiyer
class Location {
  final String company;
  final String address;
  final String city;
  final String state;
  final int zip;
  final String businessID;

  Location(
      {this.company,
      this.address,
      this.city,
      this.state,
      this.zip,
      this.businessID});

  factory Location.fromJson(Map<String, dynamic> json) {
    // print(json["location"]);
    return Location(
        company: json['company'] as String,
        address: json['location']['address'] as String,
        city: json['location']['city'] as String,
        state: json['location']['state'] as String,
        zip: json['location']['zip'] as int,
        businessID: json['business']['_id'] as String);
  }
}

class LocationBusiness extends StatefulWidget {
  static const String id = "LocationBusiness";
  LocationBusiness({Key key}) : super(key: key);

  @override
  _LocationBusinessState createState() => _LocationBusinessState();
}

class _LocationBusinessState extends State<LocationBusiness> {
  Future<Location> futureLocation;

  @override
  void initState() {
    super.initState();
    futureLocation = fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Location>(
      future: futureLocation,
      builder: (context, snapshot) {
        var data = snapshot.data;
        // print(data);
        saveLocation() async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("address", data != null ? data.address : null);
          await prefs.setString("city", data != null ? data.city : null);
          await prefs.setString("state", data != null ? data.state : null);
          await prefs.setInt("zip", data != null ? data.zip : null);
          await prefs.setString("company", data != null ? data.company : null);
          await prefs.setString(
              "businessID", data != null ? data.businessID : null);
        }

        saveLocation();
        if (snapshot.hasData) {
          return Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.place),
                    title: Text("Location"),
                  ),

                  Text("${data.company}"),
                  Text("${data.address}"),
                  Text("${data.city}"),
                  Text("${data.state}"),
                  Text("${data.zip}"),
                  // Text("${data.businessID}"),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('EDIT'),
                        onPressed: () {
                          Navigator.pushNamed(context, LocationAdd.id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return Center(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.place),
                  title: Text("Location"),
                ),
                Text("Business name: ?"),
                Text("Address: ?"),
                Text("City: ?"),
                Text("State: ?"),
                Text("zip: ?"),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('CREATE'),
                      onPressed: () {
                        Navigator.pushNamed(context, LocationAdd.id);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
