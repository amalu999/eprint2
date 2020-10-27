import 'menu.dart';
import 'package:flutter/material.dart';
class PageNew extends StatefulWidget {
  @override
  _PageNewState createState() => _PageNewState();
}

class _PageNewState extends State<PageNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("order placed"),
      ),
      drawer: MenuBar(),
    );
  }
}
