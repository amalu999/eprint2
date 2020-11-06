import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:demo_login/order.dart';

class ConfirmOrder extends StatefulWidget {
  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {


  bool processing = false;
  var emailId;
  var resId;
  var name;
  var author;
  var subject;
  var nopages;
  var price;
  var url;
  var copies;
  int p;


  void getValues() async {
    print('Getting Values from shared Preferences');
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    emailId = sharedPrefs.getString('email');
    name = sharedPrefs.getString('name_of_book');
    author = sharedPrefs.getString('author');
    subject = sharedPrefs.getString('subject');
    nopages = sharedPrefs.getString('no_of_pages');
    price = sharedPrefs.getString('price');
    url = sharedPrefs.getString('url');
    resId= sharedPrefs.getString('res_id');
    copies= sharedPrefs.get('copies');
    print('user_name: $emailId');
    print('user_name: $copies');
  }
  void orderplacing() async{

    setState(() {
      processing = true;
    });
    var url = "https://designproject---eprint.000webhostapp.com/order.php";
    var data = {
      "resid":resId,
      "email":emailId,
      "copies":copies,
    };

    var res = await http.post(url,body:data);

    if(jsonDecode(res.body) == "false"){
      Fluttertoast.showToast(msg: "failed",toastLength: Toast.LENGTH_SHORT);

    }else{ if(jsonDecode(res.body) == "true"){
      Fluttertoast.showToast(msg: "order placed",toastLength: Toast.LENGTH_SHORT);
    }else{
      if(jsonDecode(res.body) == "true"){
        Fluttertoast.showToast(msg: "order placed",toastLength: Toast.LENGTH_SHORT);
      }else{
        if(jsonDecode(res.body)=="not a number"){
          Fluttertoast.showToast(msg: "enter a number",toastLength: Toast.LENGTH_SHORT);
        }else{
          if(jsonDecode(res.body)=="invalid resource"){
            Fluttertoast.showToast(msg: "invalid resource",toastLength: Toast.LENGTH_SHORT);
          }else{
            if(jsonDecode(res.body)=="invalid user"){
              Fluttertoast.showToast(msg: "invalid user",toastLength: Toast.LENGTH_SHORT);
            }else{
              Fluttertoast.showToast(msg: "error",toastLength: Toast.LENGTH_SHORT);
            }
          }}}}}
    setState(() {
      processing = false;
    });}
  @override
  void initState() {
    super.initState();
    getValues();
  }
  Widget build(BuildContext context) {

    return
      Scaffold(
        appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.of(context).pop(),
        ),
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
              child: Text(subject),
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
              child: Text(name),
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
              child: Text(author),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("NO OF COPIES :",style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(copies),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("AMOUNT:",style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(price),


            ),
            SizedBox(height: 30,),
            Row(children: <Widget>[
              SizedBox(height: 30,width: 20),

              Center(
                child: RaisedButton(
                    child: Text("CONFIRM"),
                    onPressed:(){orderplacing();}



                ),
              ),

            ],)


          ],

        ),
      )

      );

  }}


