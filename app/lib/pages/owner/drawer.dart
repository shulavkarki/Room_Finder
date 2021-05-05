// // import 'package:app/home_page.dart';
// import 'package:app/pages/auth/service/auth_service.dart';
// import 'package:app/pages/owner/addroom.dart';
// // import 'package:app/pages/owner/homePage.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AppDrawer extends StatelessWidget {
//   // final String title;
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//         child: Column(
//       children: [
//         Expanded(
//           child: ListView(padding: EdgeInsets.zero, children: <Widget>[
//             DrawerHeader(
//               decoration: new BoxDecoration(
//                 gradient: LinearGradient(
//                     begin: Alignment.bottomRight,
//                     end: Alignment.topCenter,
//                     colors: [
//                       Colors.cyan[100],
//                       Colors.cyan[300],
//                     ]),
//               ),
//               child: Text(
//                 'Drawer Header',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//             // InkWell(
//             //   onTap: () => {
//             //     Navigator.pushReplacement(context,
//             //         MaterialPageRoute(builder: (context) => HomeOwner())),
//             //   },
//             //   child:
//             //   ListTile(
//             //     leading: Icon(
//             //       Icons.list,
//             //       size: 26.0,
//             //       color: Colors.cyan,
//             //     ),
//             //     title: Text(
//             //       'Room Lists',
//             //       style: TextStyle(fontSize: 16),
//             //     ),
//             //   ),
//             // ),
//             ListTile(
//                 leading: Icon(
//                   Icons.add,
//                   size: 26.0,
//                   color: Colors.cyan,
//                 ),
//                 title: Text(
//                   'Add a room',
//                   style: TextStyle(
//                     fontSize: 16,
//                   ),
//                 ),
//                 onTap: () => {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => AddRoom())),
//                     }),
//             // ListTile(
//             //   leading: Icon(Icons.login_outlined),
//             //   title: Text('Log Out'),
//             //   onTap: () {
//             //     context.read<AuthenticationProvider>().signOut();
//             //   },
//             // ),
//             // ListTile(
//             //   leading: Icon(Icons.login_outlined),
//             //   title: Text('Switch to map'),
//             //   onTap: () => {
//             //     Navigator.pushReplacement(
//             //         context, MaterialPageRoute(builder: (context) => Home())),
//             //   },
//             // ),
//           ]),
//         ),
//         Container(
//           child: Align(
//               alignment: FractionalOffset.bottomCenter,
//               child: Container(
//                   child: Column(
//                 children: <Widget>[
//                   Divider(),
//                   ListTile(
//                       tileColor: Colors.cyan[50],
//                       leading: Icon(
//                         Icons.logout,
//                         color: Colors.cyan,
//                       ),
//                       onTap: () {
//                         context.read<AuthenticationProvider>().signOut();
//                       },
//                       title: Text(
//                         'Log Out',
//                         style: TextStyle(
//                           fontSize: 16,
//                         ),
//                       )),
//                   // ListTile(
//                   //   // tileColor: Colors.cyan[50],
//                   //   leading: Icon(
//                   //     Icons.skip_previous,
//                   //     color: Colors.cyan,
//                   //   ),
//                   //   title: Text(
//                   //     'Switch back to home.',
//                   //     style: TextStyle(
//                   //       fontSize: 16,
//                   //     ),
//                   //   ),
//                   //   onTap: () => {
//                   //     Navigator.pushReplacement(context,
//                   //         MaterialPageRoute(builder: (context) => Home())),
//                   //   },
//                   // ),
//                 ],
//               ))),
//         )
//       ],
//     ));
//   }
// }
