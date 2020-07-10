import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:business_startup/business/BottomNavigationBusiness.dart';
import 'package:business_startup/business/LocationBusiness.dart';
import 'package:business_startup/user/BottomNavigationUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../configURL.dart';
import 'globals.dart' as globals;
import 'dart:async';
import 'dart:convert';

String name;
String businessFirstName;

autherName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // String userName = prefs.getString("name");
  String businessName = prefs.getString("firstName");
  businessFirstName = businessName;
  // name = businessName != null ? businessName : userName;
  name = businessName != null ? "business" : "user";
}

Future<List<Photo>> fetchPhotos(http.Client client) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userID = prefs.getString("userID");
  String businessID = prefs.getString("businessID");
  String userName = prefs.getString("name");
  String businessName = prefs.getString("firstName");
  businessFirstName = businessName;
  name = businessName != null ? "business" : "user";
  print("order 1 $businessFirstName");

  // user id and business id
  String json =
      '{"businessID": "${businessID == null ? globals.businessID : businessID}","userID": "${userID == null ? globals.userID : userID}"}';
  // print(json);

  var url = ConfigURL.postApiChats;
  Map<String, String> headers = {
    "Content-type": "application/json",
    // "tokenUser": "$getTokenUser"
  };
  var response = await http.post(url, headers: headers, body: json);

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String business;
  final String user;
  final String sender;
  final String message;
  final String date;

  Photo({this.business, this.user, this.sender, this.message, this.date});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      business: json['business'] as String,
      user: json['user'] as String,
      sender: json['sender'] as String,
      message: json['message'] as String,
      date: json['date'] as String,
    );
  }
}

class Chat1 extends StatelessWidget {
  // static const String id = "Chat";
  Chat1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("order 2 $businessFirstName");
    return Scaffold(
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? PhotosList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  // This is the data from the network fecth in List<>
  final List<Photo> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("order 3 $businessFirstName");
    return Scaffold(
      appBar: AppBar(
        title: Text(
            businessFirstName != null ? globals.userName : businessFirstName),
      ),
      body: ListView.builder(
        itemCount: photos.length,
        itemBuilder: (context, index) {
          var data = photos[index];

          return Align(
            alignment:
                data.sender == name ? Alignment.topRight : Alignment.topLeft,
            child: Chip(
              backgroundColor: data.sender == name
                  ? Colors.lightBlue[100]
                  : Colors.lightGreenAccent[100],
              padding: EdgeInsets.all(4),
              label: Text(data.message),
            ),
          );
        },
      ),
    );
  }
}

// Combine chat1 and chat2 on the same screen
class Chat extends StatelessWidget {
  static const String id = "Chat";
  @override
  Widget build(BuildContext context) {
    print("order 4 $businessFirstName");
    return Scaffold(
      body: ChatScreen(),
      //   body: Column(
      // children: <Widget>[
      //   Expanded(child: SizedBox(height: 500.0, child: Chat1())),
      //   // Expanded(child: SizedBox(height: 500.0, child: ChatScreen())),
      //   // NotificationsChat()
      // ],
    );
  }
}
// Flutter code sample for StreamBuilder

// class Chat2 extends StatelessWidget {
//   // static const String id = "Chat";
//   @override
//   Widget build(BuildContext context) {
//     return ChatScreen();
//   }
// }

class MessageList extends StatelessWidget {
  final List<Message> messages;

  MessageList({this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) => MessageItem(message: messages[index]),
    );
  }
}

class MessageItem extends StatelessWidget {
  final Message message;

  MessageItem({@required this.message});

  @override
  Widget build(BuildContext context) {
    // final User user = Provider.of<User>(context, listen: false);
    // final user = Provider.of<MyDataModel>(context, listen: false).company;
    // print(user);
    // print(name);
    return Align(
      alignment:
          message.sender == name ? Alignment.topRight : Alignment.topLeft,
      child: Chip(
        backgroundColor: message.sender == name
            ? Colors.lightBlue[100]
            : Colors.lightGreenAccent[100],
        padding: EdgeInsets.all(4),
        label: Text(message.message),
      ),
    );
  }
}

class MessageInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function onPressed;

  MessageInput({@required this.textEditingController, this.onPressed});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            flex: 9,
            child: TextField(
              controller: widget.textEditingController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  hintText: 'Send a message...'),
            ),
          ),
          Flexible(
            child: IconButton(
              color: Theme.of(context).primaryColor,
              disabledColor: Theme.of(context).primaryColorDark,
              icon: Icon(Icons.send),
              onPressed: widget.onPressed,
            ),
          )
        ],
      ),
    );
  }
}

// this is just a model for messages
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

  factory Message.fromJson(Map<String, dynamic> json) => new Message(
        message: json['message'],
        businessID: json['businessID'],
        userID: json['userID'],
        sender: json['sender'],
        date: json['date'],
      );

// this creates the json to be send to websocket server
  Map<String, dynamic> toJson() => {
        'message': message,
        'businessID': businessID,
        'userID': userID,
        'sender': sender,
        "date": date
      };
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final IOWebSocketChannel channel = IOWebSocketChannel.connect(
      'ws://${ConfigURL.websocketIP}${ConfigURL.websocketPort}');

  @override
  void initState() {
    super.initState();
    autherName();
  }

  final TextEditingController _textEditingController =
      new TextEditingController();

// this is our list of messages here
  List<Message> messages = [];

  @override
  Widget build(BuildContext context) {
    print("order 5 $businessFirstName");
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Expanded(child: Chat1()),
            Expanded(
              // flex: 1,
              child: StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  if (snapshot.data == null) {
                    print(businessFirstName);
                    // return Center(
                    //     child: Text('No messages yet, start typing...'));
                  } else {
                    var data = snapshot.data;
                    print(data);
                    // we are sending a json to the websocket server and recieving a json back
                    //  this decode the snapshot just like if it were a fetch from network
                    Message message = Message.fromJson(
                      jsonDecode(snapshot.data),
                    );

                    // This makes sure that the last messages is not just duplicated
                    // into the messages list
                    if (messages.isEmpty) {
                      messages.add(message);
                    } else {
                      if (message.date != messages.last.date) {
                        messages.add(message);
                      }
                    }
                  }
                  return MessageList(messages: messages);
                },
              ),
            ),
            MessageInput(
              textEditingController: _textEditingController,
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    super.dispose();
  }

  void _sendMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = prefs.getString("userID");
    String userName = prefs.getString("name");

    // Business info
    String businessID = prefs.getString("businessID");
    String businessName = prefs.getString("firstName");
    final author = businessName != null ? businessName : userName;

    final messageBody = _textEditingController.text;

    final Message message = new Message(
      message: messageBody,
      businessID: businessID != null ? businessID : globals.businessID,
      userID: userID != null ? userID : globals.userID,
      sender: businessID != null ? "business" : "user",
      date: DateTime.now().toString(),
    );
    final jsonMessage = jsonEncode(message);

    channel.sink.add(jsonMessage);

    _textEditingController.clear();
  }
}
