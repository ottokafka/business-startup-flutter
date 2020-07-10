import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:business_startup/business/AvailabilityBusiness.dart';
import 'package:business_startup/business/LocationBusiness.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BottomNavigationBusiness.dart';

class DashboardBusiness extends StatefulWidget {
  static const String id = 'dashboardBusiness';

  @override
  _DashboardBusinessState createState() => _DashboardBusinessState();
}

class _DashboardBusinessState extends State<DashboardBusiness> {
  newBusinessSteps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool work1 = prefs.getBool("work1");
    String city = prefs.getString("city");
    return [work1, city];
  }

  @override
  void initState() {
    super.initState();
    newBusinessSteps();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: newBusinessSteps(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          print(data[0]);
          if (data[0] == null) {
            return Scaffold(
              body: AvailabilityBusiness(),
              bottomNavigationBar: BottomNavigationBusiness(),
            );
          } else if (data[1] == null) {
            return Scaffold(
              body: LocationBusiness(),
              bottomNavigationBar: BottomNavigationBusiness(),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.black,
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    LocationBusiness(),
                    AvailabilityBusiness(),

                    // ServicesBusiness(),
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBusiness(),
            );
          }
        });
  }
}
