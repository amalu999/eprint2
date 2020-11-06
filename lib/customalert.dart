import 'package:flutter/material.dart';

class CustomRange extends StatelessWidget {

  TextEditingController begctrl =new TextEditingController();
  TextEditingController endctrl= new TextEditingController();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text(
            'Eprint'),
      ),

      body: Center(
        child: Container(

          width: 300,
          height: 150,
          child: Column(

              children:<Widget>[
                TextField(
                  controller: begctrl,
                  decoration: InputDecoration(
                      hintText: "Starting page number"
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                TextField(
                  controller: endctrl,
                  decoration: InputDecoration(
                      hintText: "Ending page number"
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                RaisedButton(
                  onPressed:(){} ,
                  child: Text("OK"),
                )
              ]
          ),
        ),
      ),

    );
  }
}