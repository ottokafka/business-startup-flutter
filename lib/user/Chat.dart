import 'dart:convert';
import 'package:business_startup/business/AppointmentsBusiness.dart';
import 'package:business_startup/user/AppointmentUser.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../globals.dart' as globals;
import '../configURL.dart';
import 'package:web_socket_channel/status.dart' as status;

// final _firestore = Firestore.instance;
// FirebaseUser loggedInUser;

String name;
String businessFirstName;

void autherName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // String userID = prefs.getString("userID");
  // String businessID = prefs.getString("businessID");
  // String userName = prefs.getString("name");
  String businessName = prefs.getString("firstName");
  businessFirstName = businessName;
  name = businessName != null ? "business" : "user";
  print("1");
}

class Chat extends StatelessWidget {
  static const String id = 'Chat';
  @override
  Widget build(BuildContext context) {
    print("3");
    return Scaffold(
      backgroundColor: Colors.black,
      body: CreateMsg(
        channel: IOWebSocketChannel.connect(
            'ws://${ConfigURL.websocketIP}${ConfigURL.websocketPort}'),
      ),
    );
  }
}

class CreateMsg extends StatefulWidget {
  final WebSocketChannel channel;

  CreateMsg({Key key, @required this.channel}) : super(key: key);

  @override
  _CreateMsgState createState() => _CreateMsgState();
}

class _CreateMsgState extends State<CreateMsg> {
  final messageTextController = TextEditingController();
  // final _auth = FirebaseAuth.instance;

  String messageText;

  @override
  void initState() {
    super.initState();
    autherName();
    sendMessage();
  }

  @override
  Widget build(BuildContext context) {
    print(globals.company);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (globals.company == "") {
              return Navigator.pushNamed(context, AppointmentsBusiness.id);
            }
            return Navigator.pushNamed(context, AppointmentUser.id);
          },
        ),
        title: Text(globals.company == "" ? globals.userName : globals.company),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                List<Message> myModels;
                myModels = (json.decode(snapshot.data) as List)
                    .map((i) => Message.fromJson(i))
                    .toList();

                return Expanded(
                  child: ListView.builder(
                    itemCount: myModels.length,
                    itemBuilder: (context, index) {
                      var data = myModels[index];
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
                    },
                    reverse: true,
                  ),
                );
              },
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                          color: Colors.white, backgroundColor: Colors.black),
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.message, color: Colors.black),
                        // hintText: 'Type',
                        border: OutlineInputBorder(),
                        // fillColor: Colors.black12,
                        // focusColor: Colors.black12,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      sendMessage();
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage() async {
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
    widget.channel.sink.add(jsonMessage);
    messageTextController.clear();
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
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
