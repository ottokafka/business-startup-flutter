import 'package:business_startup/user/DashboardUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:business_startup/business/servicesAction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DashboardBusiness.dart';

class ServicesAdd extends StatefulWidget {
  static const String id = "servicesAdd";
  @override
  _ServicesAddState createState() => _ServicesAddState();
}

class _ServicesAddState extends State<ServicesAdd> {
  String fade;
  String lineup;

  @override
  Widget build(BuildContext context) {
    checkToken() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String tokenUser = (prefs.getString("tokenUser"));
      String tokenBusiness = (prefs.getString("tokenBusiness"));
      print("The tokenUser is: $tokenUser");
      if (tokenUser != null) {
        Navigator.pushNamed(context, DashboardUser.id);
      }
      if (tokenBusiness != null) {
        Navigator.pushNamed(context, DashboardBusiness.id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Services"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoTextField(
              placeholder: "fade",
              clearButtonMode: OverlayVisibilityMode.editing,
              onChanged: (value) {
                fade = value;
              },
            ),
            CupertinoTextField(
              placeholder: "lineup",
              onChanged: (value) {
                lineup = value;
              },
              obscureText: false,
            ),
            SizedBox(height: 20),
            CupertinoButton.filled(
              child: Text("Add services"),
              onPressed: () {
                secondFunction() async {
                  await addServices(fade, lineup);
                  Navigator.pushNamed(context, DashboardBusiness.id);
                }

                secondFunction();
              },
            ),
          ],
        ),
      ),
    );
  }
}
