import 'package:business_startup/user/LandingUser.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as global;

class LogoutUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      onPressed: () async {
        await Alert(
          context: context,
          type: AlertType.warning,
          title: "Logout",
          desc: "Are you sure you want to logout?",
          buttons: [
            DialogButton(
              child: Text(
                "No",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => {Navigator.pop(context)},
              width: 120,
            ),
            DialogButton(
              child: Text(
                "yes",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString("tokenUser", null);
                await prefs.setString("email", null);
                await prefs.setString("name", null);
                await prefs.setString("userID", null);
                // await prefs.setString("firebaseToken", null);
                // global.firebaseToken = null;
                Navigator.pushNamed(context, LandingUser.id);
              },
              width: 120,
            )
          ],
        ).show();
      },
      icon: Icon(Icons.exit_to_app, color: Colors.white),
      label: Text(
        "LOGOUT",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
