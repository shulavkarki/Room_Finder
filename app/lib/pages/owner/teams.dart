// import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// import 'package:dio/dio.dart';
class Team extends StatefulWidget {
  @override
  _TeamState createState() => _TeamState();
}

class _TeamState extends State<Team> {
  @override
  void initState() {
    // getDate();
    super.initState();
  }

  // void getDate() {
  //   Timestamp now = Timestamp.now();
  //   DateTime dateNow = now.toDate();
  //   print(dateNow);
  // }
  // void getLocationResults(String input) async {
  //   String apiKey = 'AIzaSyCV87da7EMKy3Y3fUSyup4hMr4Pg9CNhAE';
  //   String request =
  //       'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey';

  //   Response response = await Dio().get(request);
  //   // http.Response response = await http.get(Uri.parse(request));
  //   if (response.statusCode == 200) {
  //     print(response.data);
  //   } else {
  //     throw Exception("Response not requested.");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teams"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/akhanda.png'),
                ),
                title: Text('Akhsey Sigdel'),
                subtitle: Text('something@gmail.com')),
            ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/rab.png'),
                ),
                title: Text('Rabin Pandey'),
                subtitle: Text('something2@gmail.com')),
            ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/anu.jpg'),
                ),
                title: Text('Anushka Gupta'),
                subtitle: Text('something3@gmail.com')),
            ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/loadingif.gif'),
                ),
                title: Text('Shulav Karki'),
                subtitle: Text('something4@gmail.com')),
          ],
        ),
      ),
    );
  }
}
