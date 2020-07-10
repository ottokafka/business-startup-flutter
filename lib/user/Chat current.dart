import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import '../configURL.dart';
import 'globals.dart' as globals;

String name;
String businessFirstName;
final IOWebSocketChannel channel = IOWebSocketChannel.connect(
    'ws://${ConfigURL.websocketIP}${ConfigURL.websocketPort}');

autherName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userID = prefs.getString("userID");
  String businessID = prefs.getString("businessID");
  String userName = prefs.getString("name");
  String businessName = prefs.getString("firstName");
  businessFirstName = businessName;
  name = businessName != null ? "business" : "user";
}

/// This Widget is the main application widget.
class Chat extends StatelessWidget {
  static const String id = "Chat";
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Material(
          child: Column(
        children: <Widget>[
          Expanded(child: MessagesStream()),
        ],
      )),
    );
  }
}

class Message {
  String message;
  String businessID;
  String userID;
  String sender;
  String date;

  Message({
    this.message,
    this.businessID,
    this.userID,
    this.sender,
    this.date,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      businessID: json['businessID'],
      userID: json['userID'],
      sender: json['sender'],
      date: json['date'],
    );
  }

// this creates the json to be send to websocket server
  Map<String, dynamic> toJson() => {
        'message': message,
        'businessID': businessID,
        'userID': userID,
        'sender': sender,
        "date": date
      };
}

class MessagesStream extends StatefulWidget {
  // final TextEditingController textEditingController;
  // final Function onPressed;

  MessagesStream({
    Key key,
  }) : super(key: key);

  @override
  _MessagesStreamState createState() => _MessagesStreamState();
}

class _MessagesStreamState extends State<MessagesStream> {
  // final TextEditingController _textEditingController =
  //     new TextEditingController();

  @override
  void initState() {
    super.initState();
    autherName();
    // _sendMessage();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Message> myModels;
              myModels = (json.decode(snapshot.data) as List)
                  .map((i) => Message.fromJson(i))
                  .toList();
              return Expanded(
                child: ListView.builder(
                    itemCount: myModels.length,
                    itemBuilder: (context, index) {
                      var data = myModels[index];
                      // return Text(data.message);
                      return Align(
                        alignment: data.sender == name
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        child: Chip(
                          backgroundColor: data.sender == name
                              ? Colors.lightBlue[100]
                              : Colors.lightGreenAccent[100],
                          padding: EdgeInsets.all(4),
                          label: Text(data.message),
                        ),
                      );
                    }),
              );
            }
            return TextInput();
          },
        ),
        TextInput(),
      ],
    );
  }
}

class TextInput extends StatefulWidget {
  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final messageTextController = TextEditingController();

  String messageText;
  @override
  void initState() {
    super.initState();
    // autherName();
    _sendMessage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // decoration: kMessageContainerDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: messageTextController,
                onChanged: (value) {
                  messageText = value;
                },
                // decoration: kMessageTextFieldDecoration,
              ),
            ),
            FlatButton(
              onPressed: () {
                messageTextController.clear();
                _sendMessage();
              },
              child: Text(
                'Send',
                // style: kSendButtonTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = prefs.getString("userID");
    // Business info
    String businessID = prefs.getString("businessID");
    final messageBody = messageText;

    final Message message = new Message(
      message: messageBody,
      businessID: businessID != null ? businessID : globals.businessID,
      userID: userID != null ? userID : globals.userID,
      sender: businessID != null ? "business" : "user",
      date: DateTime.now().toString(),
    );
    final jsonMessage = jsonEncode(message);
    channel.sink.add(jsonMessage);
    messageTextController.clear();
  }
}

//---------------------------------------------------------
// // Define a custom Form widget.
// class MyCustomForm extends StatefulWidget {
//   @override
//   _MyCustomFormState createState() => _MyCustomFormState();
// }

// // Define a corresponding State class.
// // This class holds the data related to the Form.
// class _MyCustomFormState extends State<MyCustomForm> {
//   // Create a text controller and use it to retrieve the current value
//   // of the TextField.
//   // final myController = TextEditingController();
//   final TextEditingController _textEditingController =
//       new TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _sendMessage();
//   }

//   @override
//   void dispose() {
//     // Clean up the controller when the widget is disposed.
//     _textEditingController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Retrieve Text Input'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: TextField(
//           controller: _textEditingController,
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         // When the user presses the button, show an alert dialog containing
//         // the text that the user has entered into the text field.
//         onPressed: () {
//           //TODO: send to server
//         },
//         tooltip: 'Show me the value!',
//         child: Icon(Icons.text_fields),
//       ),
//     );
//   }

//   void _sendMessage() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String userID = prefs.getString("userID");
//     // Business info
//     String businessID = prefs.getString("businessID");
//     final messageBody = _textEditingController.text;

//     final Message message = new Message(
//       message: messageBody,
//       businessID: businessID != null ? businessID : globals.businessID,
//       userID: userID != null ? userID : globals.userID,
//       sender: businessID != null ? "business" : "user",
//       date: DateTime.now().toString(),
//     );
//     final jsonMessage = jsonEncode(message);

//     channel.sink.add(jsonMessage);

//     _textEditingController.clear();
//   }
// }
