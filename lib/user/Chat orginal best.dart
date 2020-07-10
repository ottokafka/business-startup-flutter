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

// How to initialize variable immediatly when page loads
String name;
String businessFirstName;

autherName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userName = prefs.getString("name");
  String businessName = prefs.getString("firstName");
  businessFirstName = businessName;
  // name = businessName != null ? businessName : userName;
  name = businessName != null ? "business" : "user";
}

class Chat extends StatelessWidget {
  static const String id = "Chat";
  @override
  Widget build(BuildContext context) {
    return ChatScreen();
  }
}

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
        'sender': sender
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
    _sendMessage();
  }

  final TextEditingController _textEditingController =
      new TextEditingController();

// this is our list of messages here
  List<Message> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  if (snapshot.data == null) {
                    print(businessFirstName);
                    return Center(
                        child: Text('No messages yet, start typing...'));
                  } else {
                    var data = snapshot.data;
                    print(data);

                    // Message message = jsonDecode(snapshot.data)
                    //     .cast<Map<String, dynamic>>()
                    //     .map<Message>((json) => Message.fromJson(json))
                    //     .toList();

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
                      // if (message.uniqueID != messages.last.uniqueID) {
                      //   messages.add(message);
                      // }
                    }
                  }
                  return MessageList(messages: messages);
                },
              ),
            ),
            Expanded(
              child: MessageInput(
                textEditingController: _textEditingController,
                onPressed: _sendMessage,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: businessFirstName == null
          ? BottomNavigationUser()
          : BottomNavigationBusiness(),
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

    // User and Business will get a seperate firebase token with this code
    // String firebaseToken = prefs.getString("firebaseToken");

    // final User user = Provider.of<User>(context, listen: false);
    // await Provider.of<MyDataModel>(context, listen: false).getLocation();
    // await Provider.of<MyDataModel>(context, listen: false).fetchLocation();
    // final location =
    //     Provider.of<MyDataModel>(context, listen: false).jsonResponse;
    // print(location);

    // final author = Provider.of<MyDataModel>(context, listen: false).company;
    final author = businessName != null ? businessName : userName;
    // final businessID =
    //     Provider.of<MyDataModel>(context, listen: false).businessID;
    // print(businessID);
    // print(author);
    final messageBody = _textEditingController.text;

    final Message message = new Message(
        // the uniqueID acts as a super uniqe value that is never the same
        // uniqueID: DateTime.now().toString(),
        // author: author,
        message: messageBody,
        businessID: businessID != null ? businessID : globals.businessID,
        userID: userID != null ? userID : globals.userID,
        // firebaseToken: firebaseToken,
        sender: businessID != null ? "business" : "user");
    final jsonMessage = jsonEncode(message);

    channel.sink.add(jsonMessage);

    _textEditingController.clear();
  }
}
