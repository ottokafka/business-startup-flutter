import 'package:business_startup/configURL.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

addAppointment(
    from, businessID, userName, company, address, city, state, date) async {
  // in web use localhost but in android use 10.0.2.2
  // ios work with 127.0.0.1
  print(date);
  print('business id $businessID');
  try {
    var url = ConfigURL.putApiAppointments;
    // var url = 'http://127.0.0.1:5000/api/appointments';
//    var url = 'http://10.0.2.2:5000/api/services';
//    var url = 'https://startup-barber.herokuapp.com/api/businessinfo';
    print(userName);
    var json = jsonEncode(<String, dynamic>{
      "from": from,
      "business": businessID,
      "userName": userName,
      "company": company,
      "address": address,
      "city": city,
      "state": state,
      "date": date
    });
    print(json);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenUser = (prefs.getString("tokenUser"));

    Map<String, String> headers = {
      "Content-type": "application/json",
      "tokenUser": tokenUser
    };
    print(headers);
    var response = await http.put(url, headers: headers, body: json);

    print('Response body: ${response.body}');

    // we parse the json and use the jsonDecode method
    var parsedJson = jsonDecode(response.body);
    print(parsedJson);
  } catch (err) {
    print('Caught error: $err');
  }
}
