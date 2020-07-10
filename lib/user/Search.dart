import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:business_startup/user/searchResults.dart';

class Search extends StatefulWidget {
  static const String id = "search";

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String city = "sacramento";
//  var cityLoaded = searchCity("sacramento");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Search Business in Sacramento",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
              child: MaterialButton(
                height: 42.0,
                color: Colors.white,
                child: Text("Sacramento"),
                onPressed: () {
                  // search api to fetch businessinfo
                  // searchCity(city);
                  Navigator.pushNamed(context, SearchResults.id);

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => SearchResults()));
                },
              ),
            ),
            SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
