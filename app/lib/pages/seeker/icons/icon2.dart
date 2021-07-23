import 'package:app/shared/globals.dart';
import 'package:flutter/material.dart';

class Icon2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.local_parking, color: Global.theme4, size: 25),
      title: Text('Parking'),
    );
  }
}
