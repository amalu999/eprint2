import 'menu.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contribute extends StatefulWidget {
  @override
  _ContributeState createState() => _ContributeState();
}

class _ContributeState extends State<Contribute> {
  void customLaunch(command) async{
    if(await canLaunch(command)){
      await launch(command);
    }else{print('could not launch $command');}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Contribute"),
        ),
        drawer: MenuBar(),
        body:Column(
          children: <Widget>[
            Card(
              child: Container(
                  child:Text("Quality Notebooks are most welcomed.\n You can mail the study materials for verification.\nKindly add details in the subject")
              ),
            ),
            Card(
              child: Container(
                  child:Card(
                    child: RaisedButton(
                      child: Text('MAIL'),
                      onPressed:(){
                        customLaunch('mailto:amalususanb@gmail.com');
                      } ,

                    ) ,)
              ),
            )
          ],
        )

    );
  }
}