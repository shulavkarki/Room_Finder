import 'package:app/pages/owner/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'form/form.dart';

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  // AuthStatus _authStatus = AuthStatus.notLoggedIn;
  @override
  // void didChangeDependencies() async {
  //   super.didChangeDependencies();
  //   // final firebaseUser = Provider.of<User>(context, listen: false);
  //   String _string = await context.read<AuthenticationProvider>().onStartup();
  //   print(_string);
  //   if (_string == 'success') {
  //     setState(() {
  //       _authStatus = AuthStatus.loggedIn;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User>(context);
    Widget retVal;
    // switch (_authStatus) {
    //   case AuthStatus.notLoggedIn:
    //     retVal = FormHandler();
    //     break;
    //   case AuthStatus.loggedIn:
    //     retVal = HomeOwner();
    //     break;
    //   default:
    //     return CircularProgressIndicator();
    // }
    if (firebaseUser != null) {
      retVal = HomeOwner();
    } else {
      retVal = FormHandler();
    }
    return retVal;
  }
}
