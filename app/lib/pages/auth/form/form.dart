import 'package:app/pages/auth/form/handleForm.dart';
import 'package:flutter/material.dart';

class FormHandler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        width: size.width,
        height: size.height,
        child: TextFieldWidget(),
      ),
    );
  }
}
