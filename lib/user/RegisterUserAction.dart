import 'package:business_startup/configURL.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'CheckToken.dart';

// register User
registerUser(name, email, password, firebaseToken) async {
  print(name);
  print(email);
  print(password);
  print(firebaseToken);
  // in web use localhost but in android use 10.0.2.2
  // ios work with 127.0.0.1
  try {
    var url = ConfigURL.postApiRegisterUser;
//    var url = 'http://127.0.0.1:5000/api/registerUser';
//    var url = 'https://startup-barber.herokuapp.com/api/registerUser';
    // email has to be wrapped in " " or there will be an error
    String json =
        '{"name": "$name", "email": "$email", "password": "$password", "firebaseToken": "$firebaseToken"}';
    print(json);
    Map<String, String> headers = {"Content-type": "application/json"};
    var response = await http.post(url, headers: headers, body: json);

    print('Response body: ${response.body}');

    // we parse the json and use the jsonDecode method
    var parsedJson = jsonDecode(response.body);
    // print how just the token numbers
//  print(parsedJson["token"]);
    var tokenUser = parsedJson["tokenUser"];

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // This saves the token into the device as token: j9384ujhsdf
    await prefs.setString("tokenUser", tokenUser);
    // will grab the token from the device
    // String getTokenUser = (prefs.getString("tokenUser"));
    // show that the token is coming from device storage
    // print(getTokenUser);
  } catch (err) {
    print(err);
  }
}
