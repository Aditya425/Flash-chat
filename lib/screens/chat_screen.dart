import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _mAuth = FirebaseAuth.instance;
class ChatScreen extends StatefulWidget {
  static String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _message = "";

  @override
  Widget build(BuildContext context) {
    print(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat Screen"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
               child: MyStreamBuilder()
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(
                        text: _message
                      ),
                      onChanged: (value){
                        _message = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      if (_message.isEmpty) {
                        return;
                      }
                      String temp = _message;
                      setState(() {
                        _message = "";
                      });
                      _firestore = FirebaseFirestore.instance;
                      await _firestore.collection("messages").add({
                        "date" : DateTime.now().toString(),
                        "sender" : _mAuth.currentUser!.email,
                        "message" : temp
                      });
                    },
                    child: Icon(
                      Icons.send
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String messageText;
  final String messageSender;
  final bool isMe;

  MessageBubble({required this.messageText, required this.messageSender, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          isMe ? "You" : messageSender,
          style: TextStyle(
            fontSize: 10
          ),
        ),
        Container(
          //alignment: isMe ? Alignment.topRight : Alignment.topLeft,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isMe ? Colors.blueAccent : Colors.orange,
            borderRadius: isMe ? BorderRadius.only(topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)) :
            BorderRadius.only(topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
          ),
          child: Text(
            messageText,
            style: TextStyle(
              color: Colors.white
            ),
          ),
        )
      ],
    );
  }
}

class MyStreamBuilder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _firestore.collection("messages").orderBy("date").snapshots(),
      builder: (context, snapshots){
        List<MessageBubble> messagesList = [];
        for (QueryDocumentSnapshot snapshot in snapshots.data!.docs) {
          String messageText = snapshot.get("message");
          String messageSender = snapshot.get("sender");
          String messageReceiver = _mAuth.currentUser!.email!;

          MessageBubble bubble = MessageBubble(
            isMe: messageSender == messageReceiver,
            messageSender: messageSender,
            messageText: messageText,
          );
          messagesList.add(bubble);
        }
        return ListView(
          children: messagesList,
        );
      },
    );
  }

}