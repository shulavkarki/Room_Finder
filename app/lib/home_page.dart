import 'package:app/pages/auth/root.dart';
import 'package:app/pages/seeker/map.dart';
import 'package:app/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;

  int selectedIndex = 0;
  @override
  void initState() {
    loading = false;
    super.initState();
  }

  void switchTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List _children = [
    MapRoute(),
    Authenticate(),
  ];
  Future<bool> handleWillPop(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Are you sure?'),
              content: Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xFFFFFF),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(32.0)),
                  ),
                  child: Text('Do you want to exit?')),
              actions: <Widget>[
                MaterialButton(
                  color: Colors.white,
                  child: Text('No', style: TextStyle(color: Global.theme4)),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                MaterialButton(
                  color: Global.theme3,
                  child: Text('Yes', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                )
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => handleWillPop(context),
      child: Scaffold(
          body: _children[selectedIndex],
          bottomNavigationBar: FFNavigationBar(
            theme: FFNavigationBarTheme(
              barBackgroundColor: Colors.cyan[50],
              selectedItemBorderColor: Colors.cyan[50],
              selectedItemBackgroundColor: Colors.cyan[100],
              selectedItemIconColor: Colors.cyan[700],
              selectedItemLabelColor: Colors.grey[600],
            ),
            items: [
              FFNavigationBarItem(
                iconData: Icons.map,
                label: 'Map',
              ),
              FFNavigationBarItem(
                iconData: Icons.room,
                label: 'Add Room',
              ),
            ],
            selectedIndex: selectedIndex,
            onSelectTab: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          )),
    );
  }
}
