// import 'package:app/shared/globals.dart';
import 'package:app/pages/seeker/directions/route.dart';
import 'package:app/pages/seeker/icons/icon2.dart';
import 'package:app/shared/globals.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'icons/icon1.dart';
import 'icons/icon3.dart';
import 'icons/icon4.dart';
import 'package:timeago/timeago.dart' as timeago;

class ModalContent extends StatefulWidget {
  final Map<String, dynamic> maproom;
  const ModalContent(this.maproom);

  @override
  _ModalContentState createState() => _ModalContentState();
}

class _ModalContentState extends State<ModalContent> {
  List<String> features;
  @override
  void initState() {
    setTime();
    print(widget.maproom['neccessity'].length);

    // print(dateNow);
    super.initState();
  }

  var publishedTime;
  void setTime() {
    var now = new DateTime.now();
    var difference = now.difference(widget.maproom['time'].toDate());
    setState(() {
      publishedTime = timeago.format(now.subtract(difference));
    });
  }

  TValue case2<TOptionType, TValue>(
    TOptionType selectedOption,
    Map<TOptionType, TValue> branches, [
    TValue defaultValue = null,
  ]) {
    if (!branches.containsKey(selectedOption)) {
      return defaultValue;
    }

    return branches[selectedOption];
  }

  @override
  Widget build(BuildContext context) {
    // DateTime dateNow = widget.maproom['time'].toDate();
    // DateTime dateNow = widget.maproom['time'];
    var size = MediaQuery.of(context).size;
    return Container(
      // height: size.height * 1,
      width: size.width,
      color: Global.theme6,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 30.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox.fromSize(
                  size: Size(70, 70), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Global.theme6, // button color
                      child: InkWell(
                        splashColor: Global.theme2, // splash color
                        onTap: () {
                          UrlLauncher.launch(
                              'tel:+${widget.maproom['phone'].toString()}');
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.call,
                                size: 35, color: Global.theme4), // icon
                            Text("CALL",
                                style: TextStyle(
                                    color: Global.theme4,
                                    fontSize: 13)), // text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox.fromSize(
                  size: Size(70, 70), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: Global.theme6, // button color
                      child: InkWell(
                        splashColor: Global.theme2, // splash color
                        onTap: () {}, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.share_outlined,
                                size: 35, color: Global.theme4), // icon
                            Text("SHARE",
                                style: TextStyle(
                                    color: Global.theme4,
                                    fontSize: 13)), // text
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.cyan),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RoutePage(widget.maproom['location'])),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Directions',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.directions,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading:
                const Icon(Icons.location_on, color: Global.theme4, size: 25),
            title: Text(widget.maproom['street'].toString()),
          ),
          ListTile(
            leading: const Icon(Icons.call, color: Global.theme4, size: 25),
            title: Text(widget.maproom['phone'].toString()),
          ),
          ListTile(
            leading: const Icon(Icons.timer, color: Global.theme4, size: 25),
            title: Text(publishedTime.toString()),
          ),
          Divider(height: 10, thickness: 1.5),
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 8.0,
            ),
            child: Row(
              children: [
                Text('Description:',
                    style: TextStyle(
                        fontSize: 18,
                        color: Global.theme5,
                        fontWeight: FontWeight.w700)),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      widget.maproom["description"],
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 10, thickness: 1.5),
          ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              child: Text('More about this room.',
                  style: TextStyle(
                      fontSize: 18,
                      color: Global.theme5,
                      fontWeight: FontWeight.w700)),
            ),
            collapsed: null,
            expanded: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.maproom['neccessity'].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: case2(
                        widget.maproom['neccessity'][index],
                        {
                          "wifi": Icon1(),
                          "parking": Icon2(),
                          "water": Icon3(),
                          "kitchen": Icon4(),
                        },
                        Container(
                          child: Text('Empty!'),
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
