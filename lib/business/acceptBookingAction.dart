import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../configURL.dart';

acceptBooking(userID, accept, time, date) async {
  // in web use localhost but in android use 10.0.2.2
  // ios work with 127.0.0.1
  print(accept);

  try {
    var url = ConfigURL.postApiAppointmentsBusiness;
    // var url = 'http://127.0.0.1:5000/api/appointments/business';
//    var url = 'http://10.0.2.2:5000/api/services';
//    var url = 'https://startup-barber.herokuapp.com/api/businessinfo';

    var json = jsonEncode(<String, dynamic>{
      "user": userID,
      "accept": accept,
      "time": time,
      "date": date
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenBusiness = (prefs.getString("tokenBusiness"));

    Map<String, String> headers = {
      "Content-type": "application/json",
      "tokenBusiness": tokenBusiness
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
