import 'package:business_startup/business/DashboardBusiness.dart';
import 'package:business_startup/user/ForgotPassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:business_startup/user/DashboardUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:business_startup/user/loginUserAction.dart';

class LoginUser extends StatefulWidget {
  static const String id = "loginUser";
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  String email;
  String password;
//  String tokenUser;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
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
            CupertinoButton.filled(
              child: Text("Login"),
              onPressed: () {
                secondFunction() async {
                  await loginUser(email, password);
                  checkToken();
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
