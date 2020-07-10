import 'package:business_startup/user/BottomNavigationUser.dart';
import 'package:business_startup/user/LogoutUser.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:business_startup/configURL.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Album> fetchAlbum() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String getTokenUser = (prefs.getString("tokenUser"));
  Map<String, String> headers = {
    "Content-type": "application/json",
    "tokenUser": "$getTokenUser"
  };
  var url = ConfigURL.getApiLoginUser;

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String name;
  final String email;

  Album({this.name, this.email});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'],
      email: json['email'],
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Album>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    data.name,
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(
                    data.email,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}

class AccountUser extends StatelessWidget {
  static const String id = "AccountUser";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Account'),
      ),
      body: Column(
        children: <Widget>[
          MyApp(),
          Center(child: LogoutUser()),
        ],
      ),
      bottomNavigationBar: BottomNavigationUser(),
    );
  }
}
