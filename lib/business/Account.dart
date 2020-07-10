import 'package:business_startup/business/BottomNavigationBusiness.dart';
import 'package:business_startup/business/LogoutBusiness.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  static const String id = "Account";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Account"),
      ),
      body: Center(
        child: LogoutBusiness(),
      ),
      bottomNavigationBar: BottomNavigationBusiness(),
    );
  }
}
