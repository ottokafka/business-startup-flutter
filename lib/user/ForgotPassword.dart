import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:business_startup/configURL.dart';
import 'package:http/http.dart' as http;

class ForgotUser extends StatefulWidget {
  static const String id = "ForgotUser";

  @override
  _ForgotUserState createState() => _ForgotUserState();
}

class _ForgotUserState extends State<ForgotUser> {
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Password Reset",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                filled: true,
                icon: Icon(Icons.email),
                hintText: 'Enter your email!',
                labelText: 'Email *',
              ),
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(height: 20),
            CupertinoButton.filled(
              child: Text("Send"),
              onPressed: () async {
                send(email);
              },
            ),
          ],
        ),
      ),
    );
  }

  send(email) async {
    print(email);
    try {
      var url = ConfigURL.forgotUser;
      String json = '{"email": "$email"}';
      print(json);
      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.post(url, headers: headers, body: json);
      print('Response body: ${response.body}');
      // var parsedJson = jsonDecode(response.body);
      var data = response.body;
      Future<void> _showMyDialog() async {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title:
                  Text(data == "sent" ? "Success, Email Sent" : "Not found!"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    // Text('This is a demo alert dialog.'),
                    Text(data == "sent"
                        ? "Check your email for further instuctions"
                        : "Sorry, we didn't find this email on our side."),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }

      _showMyDialog();
      return response.body;
    } catch (err) {
      print(err);
    }
  }
}
