import 'package:business_startup/business/DashboardBusiness.dart';
import 'package:business_startup/user/LandingUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DashboardUser.dart';
import 'dart:convert';
import '../configURL.dart';
import 'package:http/http.dart' as http;

class CheckToken extends StatelessWidget {
  static const String id = "CheckToken";
  @override
  Widget build(BuildContext context) {
    saveUserDataToDevice() async {
      try {
        var url = ConfigURL.getApiLoginUser;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String getTokenUser = (prefs.getString("tokenUser"));
        Map<String, String> headers = {
          "Content-type": "application/json",
          "tokenUser": "$getTokenUser"
        };
        var response = await http.get(url, headers: headers);

        // print('Response body: ${response.body}');
        var parsedJson = jsonDecode(response.body);

        String id = parsedJson["_id"];
        String name = parsedJson["name"];
        String email = parsedJson["email"];
        String firebaseToken = parsedJson["firebaseToken"];

        // This saves the token into the device as token: j9384ujhsdf
        await prefs.setString("userID", id);
        await prefs.setString("name", name);
        await prefs.setString("email", email);
        await prefs.setString("firebaseToken", firebaseToken);
      } catch (err) {
        print(err);
      }
    }

    saveBusinessDataToDevice() async {
      try {
        var url = ConfigURL.getApiloginBusiness;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String getTokenBusiness = (prefs.getString("tokenBusiness"));
        Map<String, String> headers = {
          "Content-type": "application/json",
          "tokenBusiness": "$getTokenBusiness"
        };
        var response = await http.get(url, headers: headers);

        // print('Response body: ${response.body}');
        var parsedJson = jsonDecode(response.body);

        String id = parsedJson["_id"];
        String firstName = parsedJson["firstName"];
        String lastName = parsedJson["lastName"];
        String email = parsedJson["email"];
        String phoneNumber = parsedJson["phoneNumber"];
        String firebaseToken = parsedJson["firebaseToken"];

        // This saves the token into the device
        await prefs.setString("businessID", id);
        await prefs.setString("firstName", firstName);
        await prefs.setString("lastName", lastName);
        await prefs.setString("email", email);
        await prefs.setString("phoneNumber", phoneNumber);
        await prefs.setString("firebaseToken", firebaseToken);
      } catch (err) {
        print(err);
      }
    }

    checkToken() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String tokenUser = (prefs.getString("tokenUser"));
      String tokenBusiness = (prefs.getString("tokenBusiness"));

      if (tokenUser != null) {
        Navigator.pushNamed(context, DashboardUser.id);

        // this saveUserDataToDevice function will call an api to get user data then save to device
        await saveUserDataToDevice();
        return "tokenUser";
      }
      if (tokenBusiness != null) {
        Navigator.pushNamed(context, DashboardBusiness.id);

        await saveBusinessDataToDevice();
        return "tokenBusiness";
      }
      print("No token");
      return null;
    }

    return checkToken() == "tokenBusiness"
        ? DashboardBusiness()
        : checkToken() == "tokenUser" ? DashboardUser() : LandingUser();
  }
}
