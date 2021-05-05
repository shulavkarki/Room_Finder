import 'package:app/shared/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  // final TextEditingController _emailController = new TextEditingController();
  String _email;
  // @override
  // void dispose() {
  //   super.dispose();
  //   _emailController.dispose();
  // }
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              title: Text(''), // You can add title here
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios, color: Global.theme4),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor:
                  Colors.blue.withOpacity(0.0), //You can make this transparent
              elevation: 0.0, //No shadow
            ),
          ),
          Image.asset('assets/load.jpg', height: size.height * 0.250),
          SizedBox(height: 10),
          TextFormField(
            cursorColor: Colors.cyan,
            // controller: _emailController,
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
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
          InkWell(
            onTap: () async {
              await _auth.sendPasswordResetEmail(email: _email);
              Navigator.of(context).pop();
              Flushbar(
                message: "Request Sent! Check your mail.",
                duration: Duration(seconds: 2),
                backgroundColor: Colors.green[400],
              )..show(context);
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.cyan[400],
              ),
              height: 50.0,
              child: Center(
                child: Text(
                  'Submit',
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
        ],
      ),
    ));
  }
}
