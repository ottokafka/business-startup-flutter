import 'package:business_startup/configURL.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

addBusinessLocation(company, address, city, state, zip) async {
  // in web use localhost but in android use 10.0.2.2
  // ios work with 127.0.0.1
  try {
    // var url = 'http://127.0.0.1:5000/api/businessinfo';
    var url = ConfigURL.postApiBusinessinfo;
//    var url = 'http://10.0.2.2:5000/api/businessinfo';
//    var url = 'https://startup-barber.herokuapp.com/api/businessinfo';
    // city has to be wrapped in " " or there will be an error
    String json =
        '{"company": "$company", "address": "$address", "city": "$city", "state": "$state", "zip": "$zip"}';
    print("the user entered $json");

    // TODO: need to send a token with this request
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenBusiness = (prefs.getString("tokenBusiness"));
    await prefs.setString("company", company);
    await prefs.setString("address", address);
    await prefs.setString("city", city);
    await prefs.setString("state", state);
    await prefs.setString("zip", zip);

    // write
    // prefs.setStringList('location', [address, city, state, zip, company]);

    Map<String, String> headers = {
      "Content-type": "application/json",
      "tokenBusiness": tokenBusiness
    };
    print(headers);
    var response = await http.post(url, headers: headers, body: json);

    print('Response body: ${response.body}');

    // we parse the json and use the jsonDecode method
    var parsedJson = jsonDecode(response.body);
    print(parsedJson);
  } catch (err) {
    print('Caught error: $err');
  }
}
