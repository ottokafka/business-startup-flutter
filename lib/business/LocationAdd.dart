import 'package:business_startup/user/DashboardUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DashboardBusiness.dart';
import 'LocationAction.dart';

class LocationAdd extends StatefulWidget {
  static const String id = "addLocation";
  @override
  _LocationAddState createState() => _LocationAddState();
}

class _LocationAddState extends State<LocationAdd> {
  String company;
  String address;
  String city;
  String state;
  String zip;

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
        title: Text("Add Location"),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  filled: true,
                  icon: Icon(Icons.business),
                  hintText: 'Enter your Business name!',
                  labelText: 'Business name *',
                ),
                onChanged: (value) {
                  company = value;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  icon: Icon(Icons.directions_walk),
                  hintText: 'Enter your street address!',
                  labelText: 'street address *',
                ),
                onChanged: (value) {
                  address = value;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  filled: true,
                  icon: Icon(Icons.location_city),
                  hintText: 'Enter the City!',
                  labelText: 'City *',
                ),
                onChanged: (value) {
                  city = value.toLowerCase();
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  filled: true,
                  icon: Icon(Icons.location_city),
                  hintText: 'Enter the State!',
                  labelText: 'State *',
                ),
                onChanged: (value) {
                  state = value.toLowerCase();
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  filled: true,
                  icon: Icon(Icons.place),
                  hintText: 'Enter the zip code!',
                  labelText: 'zip *',
                ),
                onChanged: (value) {
                  zip = value;
                },
              ),

              SizedBox(height: 20),
              FlatButton.icon(
                color: Colors.lightBlue,
                onPressed: () async {
                  secondFunction() async {
                    await addBusinessLocation(
                        company, address, city, state, zip);
                    Navigator.pushNamed(context, DashboardBusiness.id);
                  }

                  secondFunction();
                },
                icon: Icon(Icons.send),
                label: Text("Save"),
              ),
              // CupertinoButton.filled(
              //   child: Text("Add Location"),
              //   onPressed: () {
              //     secondFunction() async {
              //       await addBusinessLocation(
              //           company, address, city, state, zip);
              //       Navigator.pushNamed(context, DashboardBusiness.id);
              //     }

              //     secondFunction();
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
