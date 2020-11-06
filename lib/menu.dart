import 'package:flutter/material.dart';
import 'settings.dart';
import 'contribute.dart';
import 'history.dart';
import 'page.dart';
import 'feedback.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuBar extends StatefulWidget {
  final String name;
  final String email;

  const MenuBar({Key key, this.name, this.email}) : super(key: key);
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("devika"),
              accountEmail: Text("devikathazhath@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.account_circle),
                backgroundColor: Colors.black26,
              ),
            ),
            ListTile(
                leading: Icon(Icons.add_shopping_cart),
                title: Text('Order placed'),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PageNew(),
                  ),);
                }
            ),
            ListTile(
                leading: Icon(Icons.
                history),
                title: Text('History'),
                onTap: (){ Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => History(),
                ),);

                }
            ),
            ListTile(
                leading: Icon(Icons.control_point),
                title: Text('Contribute'),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Contribute(),
                  ),);

                }
            ),
            ListTile(
                leading: Icon(Icons.feedback),
                title: Text('Feedback'),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FeedBackSend(),
                  ),);
                }
            ),
            ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: (){Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Settings(),
                ),);

                }
            ),
          ]
      ),
    );

  }
}



