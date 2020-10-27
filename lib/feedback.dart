import 'menu.dart';
import 'package:flutter/material.dart';
class FeedBackSend extends StatefulWidget {
  @override
  _FeedBackSendState createState() => _FeedBackSendState();
}

class _FeedBackSendState extends State<FeedBackSend> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      drawer: MenuBar(),
    );
  }
}
