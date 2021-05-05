import 'package:app/models/rooms.dart';
import 'package:app/pages/owner/addroom.dart';
import 'package:app/pages/owner/other.dart';
import 'package:app/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeOwner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rooms = Provider.of<List<RoomModel>>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooms'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              child: Icon(Icons.settings),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Other()));
              },
            ),
          ),
        ],
      ),
      // drawer: AppDrawer(),
      body: (rooms != null)
          ? ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ListTile(
                          tileColor: Colors.grey[50],
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          leading: const Icon(Icons.roofing,
                              color: Global.theme4, size: 40),
                          title: (rooms[index].numberofroom > 1)
                              ? Text('${rooms[index].numberofroom} rooms',
                                  style: TextStyle(
                                      fontSize: 20, color: Global.theme5))
                              : Text('${rooms[index].numberofroom} room',
                                  style: TextStyle(
                                      fontSize: 20, color: Global.theme5)),
                          trailing: Text(
                            'Rs. ${rooms[index].price.toString()}',
                            style: TextStyle(
                                color: Colors.green[900], fontSize: 16),
                          ),
                          // shape: BoxShape.rectangle,
                          subtitle: Row(
                            // mainAxisAlignment: MainAxisAlignment.,
                            children: [
                              Text(rooms[index].street),
                              Icon(Icons.location_on, color: Global.theme2),
                            ],
                          )
                          // onTap: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           // builder: (context) => AddRoom(rooms[index])));
                          //           builder: (context) => AddRoom()));
                          // },
                          ),
                      Divider(
                        color: Global.theme5,
                        height: 10,
                        thickness: 1,
                      )
                    ],
                  ),
                );
              })
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return ScaleTransition(
                      alignment: Alignment.center,
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return AddRoom();
                  }));

          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => AddRoom()));
        },
        label: Text('Add a room'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.cyan[300],
        splashColor: Colors.cyan[500],
      ),
    );
  }
}
