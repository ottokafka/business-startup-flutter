import 'package:business_startup/configURL.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

addAvailability(
    work1,
    work2,
    work3,
    work4,
    work5,
    work6,
    work7,
    start_time1,
    end_time1,
    start_time2,
    end_time2,
    start_time3,
    end_time3,
    start_time4,
    end_time4,
    start_time5,
    end_time5,
    start_time6,
    end_time6,
    start_time7,
    end_time7) async {
  // in web use localhost but in android use 10.0.2.2
  // ios work with 127.0.0.1
  try {
    var url = ConfigURL.putApiAvailability;
    // var url = 'http://127.0.0.1:5000/api/availability';
//    var url = 'http://10.0.2.2:5000/api/availability';
//    var url = 'https://startup-barber.herokuapp.com/api/businessinfo';
    // start_time2 has to be wrapped in " " or there will be an error

    var body = jsonEncode(<String, dynamic>{
      "day_of_week1": "Monday",
      "work1": work1,
      'start_time1': work1 == true ? start_time1 : null,
      "end_time1": work1 == true ? end_time1 : null,
      "day_of_week2": "Tuesday",
      "work2": work2,
      'start_time2': work2 == true ? start_time2 : null,
      "end_time2": work2 == true ? end_time2 : null,
      "day_of_week3": "Wednesday",
      "work3": work3,
      'start_time3': work3 == true ? start_time3 : null,
      "end_time3": work3 == true ? end_time3 : null,
      "day_of_week4": "Thursday",
      "work4": work4,
      'start_time4': work4 == true ? start_time4 : null,
      "end_time4": work4 == true ? end_time4 : null,
      "day_of_week5": "Friday",
      "work5": work5,
      'start_time5': work5 == true ? start_time5 : null,
      "end_time5": work5 == true ? end_time5 : null,
      "day_of_week6": "Saturday",
      "work6": work6,
      'start_time6': work6 == true ? start_time6 : null,
      "end_time6": work6 == true ? end_time6 : null,
      "day_of_week7": "Sunday",
      "work7": work7,
      'start_time7': work7 == true ? start_time7 : null,
      "end_time7": work7 == true ? end_time7 : null,
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenBusiness = (prefs.getString("tokenBusiness"));

    Map<String, String> headers = {
      "Content-type": "application/json",
      "tokenBusiness": tokenBusiness
    };
    print(headers);
    var response = await http.put(url, headers: headers, body: body);

    print('Response body: ${response.body}');

    // we parse the json and use the jsonDecode method
    var parsedJson = jsonDecode(response.body);
    print(parsedJson);
  } catch (err) {
    print('Caught error: $err');
  }
}
