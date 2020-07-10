import 'package:business_startup/configURL.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Login business
loginBusiness(email, password) async {
  print(email);
  print(password);
  // in web use localhost but in android use 10.0.2.2
  // ios work with 127.0.0.1
  try {
    var url = ConfigURL.postApiloginBusiness;
//    var url = 'http://127.0.0.1:5000/api/loginBusiness';
//    var url = 'http://10.0.2.2:5000/api/loginBusiness';
//    var url = 'https://startup-barber.herokuapp.com/api/loginBusiness';
    // email has to be wrapped in " " or there will be an error
    String json = '{"email": "$email", "password": "$password"}';
    print(json);
    Map<String, String> headers = {"Content-type": "application/json"};
    var response = await http.post(url, headers: headers, body: json);

    print('Response body: ${response.body}');

    // we parse the json and use the jsonDecode method
    var parsedJson = jsonDecode(response.body);
    // print how just the token numbers
//  print(parsedJson["token"]);
    var tokenBusiness = parsedJson["tokenBusiness"];
    var firstName = parsedJson["firstName"];
    var lastName = parsedJson["lastName"];
    var email2 = parsedJson["email"];
    var phoneNumber = parsedJson["phoneNumber"];

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // This saves the token into the device as token: j9384ujhsdf
    await prefs.setString("tokenBusiness", tokenBusiness);
    await prefs.setString("email", email2);
    await prefs.setString("firstName", firstName);
    await prefs.setString("lastName", lastName);
    await prefs.setString("phoneNumber", phoneNumber);

    // write
    // prefs.setStringList('barberinfo', [firstName, lastName, email2, phoneNumber]);

    // will grab the token from the device
    String gettokenBusiness = (prefs.getString("tokenBusiness"));

    // show that the token is coming from device storage
    print(gettokenBusiness);
  } catch (err) {
    print('Caught error: $err');
  }
}
