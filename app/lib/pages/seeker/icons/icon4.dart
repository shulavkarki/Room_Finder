import 'package:app/shared/globals.dart';
import 'package:flutter/material.dart';

class Icon4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          const Icon(Icons.kitchen_outlined, color: Global.theme4, size: 25),
      title: Text('Kitchen'),
    );
  }
}
