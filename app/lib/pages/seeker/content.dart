import 'package:flutter/material.dart';

class ContentSheet extends StatefulWidget {
  @override
  _ContentSheetState createState() => _ContentSheetState();
}

class _ContentSheetState extends State<ContentSheet> {
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Divider(
      color: Colors.grey,
      height: 5,
      // : size.width * 0.3,
    );
  }
}
