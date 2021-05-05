import 'package:app/pages/auth/form/reset.dart';
import 'package:app/pages/auth/service/auth_service.dart';
import 'package:app/shared/globals.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class TextFieldWidget extends StatefulWidget {
  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Stream _connectivityStream = Connectivity().onConnectivityChanged;

  @override
  void dispose() {
    super.dispose();
    if (mounted) {
      _emailController.dispose();
      _passwordController.dispose();
    }
    // _connectivityStream.cancel();
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextFormField(
            cursorColor: Global.theme4,
            controller: _emailController,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.email(context),
              FormBuilderValidators.required(context),
            ]),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey),
              fillColor: Colors.grey[200],
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.blueGrey, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.cyan[200], width: 2),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.email(context),
              FormBuilderValidators.required(context),
            ]),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey),
              fillColor: Colors.grey[200],
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.blueGrey, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.cyan[200], width: 2),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  print('tapeed');
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          // transitionDuration: Duration(seconds: 1),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                        return ScaleTransition(
                          alignment: Alignment.center,
                          scale: animation,
                          child: child,
                        );
                      }, pageBuilder: (context, animation, animationTime) {
                        return ResetScreen();
                      }));
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.cyan, fontSize: 15),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              checkInternet('login');
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.cyan[400],
                // borderRadius: BorderRadius.circular(20),
              ),
              height: 50.0,
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    // color: hasBorder ? Global.mediumBlue : Global.white,
                    color: Colors.white,
                    letterSpacing: 1.70,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          InkWell(
            onTap: () {
              checkInternet('signup');
            },
            // borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.cyan),
                // color: Colors.cyan[100],
                // borderRadius: BorderRadius.circular(20),
              ),
              height: 50.0,
              child: Center(
                child: Text(
                  'Register',
                  style: TextStyle(
                      // color: hasBorder ? Global.mediumBlue : Global.white,
                      color: Colors.cyan,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                      letterSpacing: 1.7),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  checkInternet(String value) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      showDialog(
          context: _scaffoldKey.currentContext,
          builder: (context) {
            return Center(
              child: Column(
                children: [
                  Center(child: CircularProgressIndicator()),
                ],
              ),
            );
          });
      if (value == 'login') {
        await context.read<AuthenticationProvider>().signIn(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );
      } else if (value == 'signup') {
        context.read<AuthenticationProvider>().signUp(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );
      }
      return Navigator.pop(context);
    } else {
      Flushbar(
        message: "Check internet Connection",
        duration: Duration(seconds: 2),
        backgroundColor: Colors.orange[300],
      )..show(context);
    }
  }
}
