import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:business_startup/user/Search.dart';
import 'BottomNavigationUser.dart';

class DashboardUser extends StatelessWidget {
  static const String id = "dashboardUser";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
            //     child: MaterialButton(
            //       height: 42.0,
            //       color: Colors.lightBlue,
            //       child: Text("Search"),
            //       onPressed: () {
            //         // Navigator.push(context,
            //         //     MaterialPageRoute(builder: (context) => Search()));
            //         Navigator.pushNamed(context, Search.id);
            //       },
            //     ),
            //   ),
            // ),
            FlatButton.icon(
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, Search.id);
                },
                icon: Icon(Icons.search),
                label: Text("Search")),
            SizedBox(height: 6),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationUser(),
    );
  }
}
