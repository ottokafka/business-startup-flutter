import 'package:business_startup/user/ForgotPassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:business_startup/business/loginBusinessAction.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DashboardBusiness.dart';

class LoginBusiness extends StatefulWidget {
  static const String id = "loginBusiness";

  @override
  _LoginBusinessState createState() => _LoginBusinessState();
}

class _LoginBusinessState extends State<LoginBusiness> {
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    checkToken() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String tokenBusiness = (prefs.getString("tokenBusiness"));
      print("The tokenBusiness is: $tokenBusiness");
      if (tokenBusiness != null) {
        Navigator.pushNamed(context, DashboardBusiness.id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                filled: true,
                icon: Icon(Icons.email),
                hintText: 'Enter your email to login!',
                labelText: 'Email *',
              ),
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
//              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            FlatButton(
                onPressed: () {
                  print("forgot password");
                  Navigator.pushNamed(context, ForgotUser.id);
                },
                child: Text("Forgot password")),
            SizedBox(height: 20),
            FlatButton.icon(
              color: Colors.lightBlue,
              onPressed: () async {
                await loginBusiness(email, password);
                checkToken();
              },
              icon: Icon(Icons.send),
              label: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
