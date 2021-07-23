import 'package:app/shared/globals.dart';
import 'package:flutter/material.dart';

class Icon1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.wifi, color: Global.theme4, size: 25),
      title: Text('Wifi'),
    );
  }
}
