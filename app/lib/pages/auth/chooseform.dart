// import 'package:app/pages/auth/form/login.dart';
// import 'package:app/pages/auth/form/register.dart';
// import 'package:flutter/material.dart';

// class Choose extends StatefulWidget {
//   @override
//   _ChooseState createState() => _ChooseState();
// }

// class _ChooseState extends State<Choose> with SingleTickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       initialIndex: 0,
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.cyan[200],
//           title: Text(
//             'Login/Resgistraion',
//             // style: TextStyle(color: Colors.blueGrey),
//           ),
//           bottom: TabBar(
//             indicator: UnderlineTabIndicator(
//                 borderSide: BorderSide(width: 3.0, color: Colors.blueGrey[600]),
//                 insets: EdgeInsets.symmetric(horizontal: 16.0)),
//             unselectedLabelColor: Colors.white,
//             labelColor: Colors.blueGrey[600],
//             tabs: <Widget>[
//               new Tab(
//                 icon: Icon(Icons.app_registration),
//                 text: 'Register',
//               ),
//               new Tab(
//                 icon: Icon(Icons.login),
//                 text: 'Login',
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: <Widget>[
//             SignUpPage(),
//             LoginPage(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // import 'package:app/pages/auth/form/login.dart';
// // import 'package:app/pages/auth/form/register.dart';
// // import 'package:flutter/material.dart';

// // class Choose extends StatefulWidget {
// //   @override
// //   _ChooseState createState() => _ChooseState();
// // }

// // class _ChooseState extends State<Choose> with SingleTickerProviderStateMixin {
// //   @override
// //   Widget build(BuildContext context) {
// //     return DefaultTabController(
// //       initialIndex: 0,
// //       length: 2,
// //       child: Scaffold(
// //         body: NestedScrollView(
// //           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
// //             return <Widget>[
// //               new SliverAppBar(
// //                 title: Text('Tabs Demo'),
// //                 pinned: true,
// //                 floating: true,
// //                 bottom: TabBar(
// //                   indicator: UnderlineTabIndicator(
// //                       borderSide:
// //                           BorderSide(width: 3.0, color: Colors.blueGrey[600]),
// //                       insets: EdgeInsets.symmetric(horizontal: 16.0)),
// //                   unselectedLabelColor: Colors.white,
// //                   labelColor: Colors.blueGrey[600],
// //                   tabs: <Widget>[
// //                     new Tab(
// //                       icon: Icon(Icons.login),
// //                       text: 'Login',
// //                     ),
// //                     new Tab(
// //                       icon: Icon(Icons.app_registration),
// //                       text: 'Register',
// //                     ),
// //                   ],
// //                 ),
// //               )
// //             ];
// //           },
// //           body: TabBarView(
// //             children: <Widget>[
// //               LoginPage(),
// //               SignUpPage(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
