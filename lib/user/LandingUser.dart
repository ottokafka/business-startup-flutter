import 'package:business_startup/business/DashboardBusiness.dart';
import 'package:business_startup/user/CheckToken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:business_startup/business/LandingBusiness.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DashboardUser.dart';
import 'LoginUser.dart';
import 'RegisterUser.dart';

class LandingUser extends StatelessWidget {
  static const String id = "LandingUser";
  @override
  Widget build(BuildContext context) {
    checkToken() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String tokenUser = (prefs.getString("tokenUser"));
      String tokenBusiness = (prefs.getString("tokenBusiness"));

      if (tokenUser != null) {
        Navigator.pushNamed(context, DashboardUser.id);
        // print(tokenUser);
        return "tokenUser";
      }
      if (tokenBusiness != null) {
        Navigator.pushNamed(context, DashboardBusiness.id);
        // print(tokenBusiness);
        return "tokenBusiness";
      }
      print("No token");
      return null;
    }

    // print(checkToken());

    return Scaffold(
      backgroundColor: Colors.white,
//      appBar: AppBar(
//        title: Text("Home"),
//        backgroundColor: Colors.lightBlueAccent,
//      ),
// ternarary operator if true do the first one if not do the other
      body: Center(
        child: Column(
          // This mainAxisAlignment puts the elements in the middle of the phone
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
//          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // will connect to firebase server to give token for messages.

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
              child: Center(
                child: Text(
                  "My Startup",
                  style: TextStyle(
                      color: CupertinoColors.inactiveGray, fontSize: 40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
              child: MaterialButton(
                height: 42.0,
                color: Colors.lightBlue,
                child: Text("Login"),
                onPressed: () {
                  checkToken();
                  Navigator.pushNamed(context, LoginUser.id);
                },
              ),
            ),
            SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: MaterialButton(
                height: 42.0,
                color: Colors.lightBlueAccent,
                child: Text("Register"),
                onPressed: () {
                  checkToken();
                  Navigator.pushNamed(context, RegisterUser.id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 50, 32, 0),
              child: MaterialButton(
                height: 42.0,
                color: Colors.black,
                textColor: Colors.white,
                child: Text("Business"),
                onPressed: () {
                  checkToken();
                  Navigator.pushNamed(context, LandingBusiness.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
