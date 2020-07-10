import 'package:business_startup/user/DashboardUser.dart';
import 'package:business_startup/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:business_startup/business/RegisterBusinessAction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as globals;
import 'DashboardBusiness.dart';

class RegisterBusiness extends StatefulWidget {
  static const String id = "registerBusiness";
  @override
  _RegisterBusinessState createState() => _RegisterBusinessState();
}

class _RegisterBusinessState extends State<RegisterBusiness> {
  String password;
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  // form for validating
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    checkToken() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String tokenUser = (prefs.getString("tokenUser"));
      String tokenBusiness = (prefs.getString("tokenBusiness"));

      if (tokenUser != null) {
        Navigator.pushNamed(context, DashboardUser.id);
      }
      if (tokenBusiness != null) {
        Navigator.pushNamed(context, DashboardBusiness.id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign-up Barber"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(4, 20, 8, 4),
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
                    hintText: 'Enter your first name!',
                    labelText: 'First Name *',
                  ),
                  onChanged: (value) {
                    firstName = value;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    return nameValidator(value);
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    icon: Icon(Icons.person),
                    hintText: 'Enter your last name!',
                    labelText: 'Last Name *',
                  ),
                  onChanged: (value) {
                    lastName = value;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    return emailValidator(value);
                  },
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
                TextFormField(
                  validator: (value) {
                    return phoneValidator(value);
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    icon: Icon(Icons.phone),
                    hintText: 'Enter your phone number!',
                    labelText: 'Phone *',
                  ),
                  onChanged: (value) {
                    phoneNumber = value;
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
                FlatButton.icon(
                  color: Colors.lightBlue,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      SnackBar(content: Text('Processing Data'));
                      await registerBusiness(firstName, lastName, email,
                          password, phoneNumber, globals.firebaseToken);
                      checkToken();
                    }
                  },
                  icon: Icon(Icons.forward),
                  label: Text("Done"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
