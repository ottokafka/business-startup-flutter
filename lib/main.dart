import 'package:business_startup/business/Account.dart';
// import 'package:business_startup/src/screens/welcome_screen.dart';

import 'package:business_startup/user/AccountUser.dart';
import 'package:business_startup/user/AppointmentUser.dart';
import 'package:business_startup/user/CheckToken.dart';
import 'package:business_startup/user/Chat.dart';
import 'package:business_startup/user/ForgotPassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:business_startup/business/AvailabilityAdd.dart';
import 'package:business_startup/business/LocationAdd.dart';
import 'package:business_startup/business/LandingBusiness.dart';
import 'package:business_startup/business/LocationBusiness.dart';
import 'package:business_startup/business/LoginBusiness.dart';
import 'package:business_startup/business/RegisterBusiness.dart';
import 'package:business_startup/business/DashboardBusiness.dart';
import 'package:business_startup/business/servicesAdd.dart';
import 'package:business_startup/user/DashboardUser.dart';
import 'business/AppointmentsBusiness.dart';
import 'user/CheckAvailability.dart';
import 'user/LandingUser.dart';
import 'user/RegisterUser.dart';
import 'user/LoginUser.dart';
import 'user/Search.dart';
import 'user/SearchBusinessInfo.dart';
import 'user/searchResults.dart';

void main() => runApp(BusinessStartup());

class BusinessStartup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: CheckToken.id,
      routes: {
        // MyApp.id: (context) => MyApp(),
        CheckToken.id: (context) => CheckToken(),
        // Business
        Account.id: (context) => Account(),
        LandingBusiness.id: (context) => LandingBusiness(),
        LoginBusiness.id: (context) => LoginBusiness(),
        RegisterBusiness.id: (context) => RegisterBusiness(),
        DashboardBusiness.id: (context) => DashboardBusiness(),
        LocationAdd.id: (context) => LocationAdd(),
        LocationBusiness.id: (context) => LocationBusiness(),
        AvailabilityAdd.id: (context) => AvailabilityAdd(),
        ServicesAdd.id: (context) => ServicesAdd(),
        AppointmentsBusiness.id: (context) => AppointmentsBusiness(),

        // User
        LandingUser.id: (context) => LandingUser(),
        LoginUser.id: (context) => LoginUser(),
        RegisterUser.id: (context) => RegisterUser(),
        DashboardUser.id: (context) => DashboardUser(),
        Search.id: (context) => Search(),
        SearchResults.id: (context) => SearchResults(),
        CheckAvailability.id: (context) => CheckAvailability(),
        AppointmentUser.id: (context) => AppointmentUser(),
        AccountUser.id: (context) => AccountUser(),
        Chat.id: (context) => Chat(),
        SearchBussinessInfo.id: (context) => SearchBussinessInfo(),
        ForgotUser.id: (context) => ForgotUser(),
      },
    );
  }
}
