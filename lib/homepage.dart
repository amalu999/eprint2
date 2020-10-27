
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '';
import 'package:demo_login/menu.dart';
class Frontpage extends StatefulWidget {
  @override
  _FrontpageState createState() => _FrontpageState();
}
class _FrontpageState extends State<Frontpage> {
  Icon cusicon = Icon(Icons.search);
  Widget cussearchbar = Text('BOOKS');
  getMethod() async{
    String theUrl='https://designproject---eprint.000webhostapp.com/getData.php';
    var res = await http.get(Uri.encodeFull(theUrl),headers: {"Accept":"application/json"});
    var responseBody=json.decode(res.body);
    print(responseBody);
    return responseBody;

  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          titleSpacing: 20.0,
          actions : <Widget>[
            IconButton(
              onPressed: (){
                setState(() {
                  if (this.cusicon.icon == Icons.search) {
                    this.cusicon = Icon(Icons.cancel);
                    this.cussearchbar = TextField(
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search books"
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    );
                  }
                  else{
                    this.cusicon = Icon(Icons.search);
                    this.cussearchbar = Text('BOOKS');
                  }
                });
              },
              icon: cusicon,
            )
          ],
          title: cussearchbar,
          backgroundColor: Colors.blue,
        ),
        drawer: MenuBar(),
        body: FutureBuilder(
            future: getMethod(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              List snap=snapshot.data;
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError){
                return Center(child: Text('Error fetching data'));
              }
              return ListView.builder(
                  itemCount: snap.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: ListTile(
                        title: Text("${snap[index]['NAME']}"),
                        subtitle: Text("${snap[index]['AUTHOR']}"),
                        //readurl="${snap[index]['URL']}",
                        onTap:(){
                          setState(() {

                            _launchInBrowser('${snap[index]['URL']}');
                          });

                        },

                        trailing:  Icon(Icons.print),
                      ),
                    );
                  });
            }
        )
    );
  }
}
