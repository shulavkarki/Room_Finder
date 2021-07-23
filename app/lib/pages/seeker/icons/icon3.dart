import 'package:app/shared/globals.dart';
import 'package:flutter/material.dart';

class Icon3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.water_damage_outlined,
          color: Global.theme4, size: 25),
      title: Text('Water'),
    );
  }
}
