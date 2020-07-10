import 'package:business_startup/business/DashboardBusiness.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:business_startup/user/RegisterUserAction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../validator.dart';
import 'CheckToken.dart';
import '../globals.dart' as globals;

class RegisterUser extends StatefulWidget {
  static const String id = "registerUser";

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  String name;
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    checkToken() async {
      // CheckToken();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String tokenUser = (prefs.getString("tokenUser"));
      String tokenBusiness = (prefs.getString("tokenBusiness"));
      print("The tokenUser is: $tokenUser");
      if (tokenUser != null || tokenBusiness != null) {
        Navigator.pushNamed(context, CheckToken.id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  return nameValidator(value);
                },
                decoration: const InputDecoration(
                  filled: true,
                  icon: Icon(Icons.person),
                  hintText: 'Enter your name!',
                  labelText: 'Name *',
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (validEmail) {
                  return emailValidator(validEmail);
                },
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
              TextFormField(
                validator: (value) {
                  return passwdValidator(value);
                },
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
              SizedBox(height: 20),
              CupertinoButton.filled(
                child: Text("Register"),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.

                    SnackBar(content: Text('Processing Data'));
                    print("test ${globals.firebaseToken}");
                    secondFunction() async {
                      await registerUser(
                          name, email, password, globals.firebaseToken);
                      checkToken();
                    }

                    secondFunction();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
