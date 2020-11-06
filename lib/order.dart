import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:demo_login/orderConfirmation.dart';

import 'CoderConfirmation.dart';

class OrderDetails extends StatefulWidget {
final String nameOfBook;
final String author;
final String subject;
OrderDetails({Key key, this.subject, this.nameOfBook, this.author});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  var emailId;
  var resId;
  var author;
  var subject;
  var nopages;
  var price;
  var url;
  var nameOfBook;

  TextEditingController copyctrl;
  void getValues() async {
    print('Getting Values from shared Preferences');
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    emailId = sharedPrefs.getString('email');
    nameOfBook= sharedPrefs.getString('name_of_book');
    author = sharedPrefs.getString('author');
    subject = sharedPrefs.getString('subject');
    nopages = sharedPrefs.getString('no_of_pages');
    price = sharedPrefs.getInt('price');
    url = sharedPrefs.getString('url');
    resId= sharedPrefs.getString('res_id');
    print('user_name: $emailId');
    print('resId: $resId');
    print('book = $nameOfBook');

  }
  void setValues(copies) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    // set values
    sharedPrefs.setString('copies', copyctrl.text);
    print('Values Set in Shared Prefs!!');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    copyctrl = new TextEditingController();}

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  void confirmOrder(){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ConfirmOrder(),
    ),);
  }

  noOfCopiesDialog(){
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed:  () {
        setValues(copyctrl);
        confirmOrder();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text('Number of Copies') ,
      content: TextField(
        controller: copyctrl,
        decoration: InputDecoration(
            hintText: "Enter the required number of copies you want"
        ),
        keyboardType: TextInputType.numberWithOptions(),
      ),
      //Text("Enter the required number of copies you want"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }



  showAlertDialog() {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("YES"),
      onPressed:  () {
        ConfirmcOrder();
      },
    );
    Widget continueButton = FlatButton(
        child: Text("NO"),
        onPressed:(){ noOfCopiesDialog();}
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Would you like to customize the textbook?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  void initState1() {
    super.initState();
    getValues();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),

        body:Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("SUBJECT :",style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.subject),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("BOOKNAME :",style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.nameOfBook),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("AUTHOR :",style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.author),
              ),
              SizedBox(height: 30,),
              Row(children: <Widget>[
                SizedBox(height: 30,width: 20),


                RaisedButton(
                  child: Center(child: Text("READ")),
                  onPressed:(){
                    _launchInBrowser(url);
                  }, ),
                SizedBox(width: 40),
                RaisedButton(child:Center(child: Text("PRINT")),onPressed:(){showAlertDialog();} )
              ],)


            ],

          ),
        )
    );
  }
}