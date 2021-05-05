import 'dart:async';
import 'package:app/home_page.dart';
// import 'package:app/pages/auth/form/form.dart';
import 'package:app/pages/auth/service/auth_service.dart';
// import 'package:app/pages/owner/homePage.dart';
import 'package:app/provider/room_provider.dart';
import 'package:app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // BuildContext context;
  // final firebaseUser = context.watch<User>();
  runApp(MyApp());
}

Future<void> getUser() async {
  return await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  final fireStoreService = FirestoreService();
  // User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationProvider>().authState,
        ),
        ChangeNotifierProvider(
          create: (context) => RoomProvider(),
        ),
        StreamProvider(
          create: (context) => fireStoreService.getRooms(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.cyan[300]),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        // home: AnimatedSplashScreen.withScreenFunction(
        //   splash: 'assets/check.png',
        //   screenFunction: () async {
        //     return Home();
        //   },
        //   splashTransition: SplashTransition.fadeTransition,
        //   // pageTransitionType: PageTransitionType.scale,
        // )
        routes: {
          '/': (context) => Home(),
        },
      ),
    );
  }
}

// ignore: must_be_immutable
// class Authenticate extends StatefulWidget {
//   // bool loading;

//   // Authenticate(this.loading);
//   @override
//   _AuthenticateState createState() => _AuthenticateState();
// }

// class _AuthenticateState extends State<Authenticate> {
//   // bool aunthenticated = false;
//   // bool loading = true;
//   @override
//   // ignore: missing_return
//   Widget build(BuildContext context) {
//     final firebaseUser = Provider.of<User>(context);

//     if (firebaseUser != null) {
//       return HomeOwner();
//     }

//     return FormHandler();
//   }
// }

// class Authenticate extends StatefulWidget {
//   @override
//   _AuthenticateState createState() => _AuthenticateState();
// }

// class _AuthenticateState extends State<Authenticate> {
//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = Provider.of<User>(context);

//     if (firebaseUser != null) {
//       return HomeOwner();
//     }
//     return FormHandler();
//   }
// }
