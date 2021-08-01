import 'dart:async';
// import 'dart:convert';

import 'package:app/pages/seeker/bottomSheet.dart';
import 'package:app/pages/seeker/modalContent.dart';
import 'package:app/shared/globals.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:http/http.dart' as http;

class MapRoute extends StatefulWidget {
  final String title;
  const MapRoute({Key key, this.title}) : super(key: key);

  @override
  _MapRouteState createState() => _MapRouteState();
}

class _MapRouteState extends State<MapRoute> {
  GlobalKey btnKey = GlobalKey();
  Completer<GoogleMapController> _controller = Completer();

  ValueNotifier<bool> isSelect = ValueNotifier(false);
  var aaa = "false";
  List<Map<String, dynamic>> room = [];
  Set<Marker> allMarkers = {};
  // LocationResult _pickedLocation;

  @override
  void didChangeDependencies() async {
    gettingRooms();
    super.didChangeDependencies();
  }

  // BitmapDescriptor customIcon;

  // void setCustomMarkerIcon() async {
  //   customIcon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(devicePixelRatio: 2.5), 'assets/last.png');
  // }

  void _showModal(Map<String, dynamic> maproom) {
    var size = MediaQuery.of(context).size;
    // Future<void> future =
    showStickyFlexibleBottomSheet(
      minHeight: 0,
      initHeight: 0.5,
      maxHeight: 0.9,
      headerHeight: size.height * 0.3,
      context: context,
      headerBuilder: (BuildContext context, double offset) {
        return Container(
          height: size.height * 0.35,
          decoration: BoxDecoration(
            color: Global.theme1,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)),
          ),
          child: ModalImage(maproom['img']),
        );
      },
      builder: (BuildContext context, double offset) {
        return SliverChildListDelegate(
          <Widget>[
            Column(
              children: [
                ModalContent(maproom),
              ],
            )
          ],
        );
      },
      anchors: [0, 0.5, 1],
    );
  }

  LatLng location;
  String apiKey = "AIzaSyCV87da7EMKy3Y3fUSyup4hMr4Pg9CNhAE";

  int i = 0;
  saveData(dynamic value, int length) {
    // int i = 0;
    if (this.mounted) {
      setState(() {
        if (i != length) {
          room.add(value);
          double latitude = double.parse(room[i]['location'][0]);
          double longitude = double.parse(room[i]['location'][1]);
          location = new LatLng(latitude, longitude);

          allMarkers.add(Marker(
              infoWindow: InfoWindow(
                  title: "Number of Room : ${room[i]['numberofroom']} ",
                  snippet: "Phone number: ${room[i]['phone'].toString()}"),
              markerId: MarkerId(room[i]['description']),
              position: location,
              onTap: () {}));
          i++;
        }
      });
    }
  }

  gettingRooms() async {
    Stream<QuerySnapshot> _db = FirebaseFirestore.instance
        .collection("rooms")
        .where('published', isEqualTo: true)
        .snapshots();
    _db.forEach((field) {
      field.docs.asMap().forEach((key, value) {
        saveData(value.data(), field.size);
      });
    });
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 20,
      tilt: 45.0,
    )));
  }

  void placeList(String placeName) async {
    if (placeName.length > 1) {
      // String autoComplete =
      //     "https://maps.googleapis.com/maps/api/place/autocomplete/xml?input=$placeName&types=establishment&location=26.797091768525963, 87.29033879308038&radius=500&strictbounds&key=$apiKey";
      final res = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/place/autocomplete/xml?input=$placeName&types=establishment&location=26.797091768525963, 87.29033879308038&radius=500&strictbounds&key=$apiKey'));
      if (res.statusCode == 200) {
        print(res);
      } else
        throw Exception('Failed to load Places.');
    }
  }

  int count = 0;
  List maptype = [
    MapType.normal,
    MapType.hybrid,
    MapType.terrain,
    MapType.satellite,
  ];
  // mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Container(
          height: height,
          width: width,
          child: GoogleMap(
              markers: allMarkers,
              mapType: maptype[count],
              initialCameraPosition: CameraPosition(
                target: LatLng(26.797091768525963, 87.29033879308038),
                zoom: 16.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              }),
        ),
        buildFloatingSearchBar(),
        (room != null)
            ? Positioned(
                bottom: 15.0,
                child: Container(
                  height: height * 0.18,
                  width: width,
                  child: CarouselSlider.builder(
                      itemCount: room.length,
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        // reverse: true,
                        autoPlay: true,
                        aspectRatio: 1.0,
                        enlargeCenterPage: true,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return _boxes(room[index], index);
                      }),
                ),
              )
            : SizedBox(width: 0, height: 0),
      ],
    );
  }

  int prevPage;
  Widget _boxes(Map<String, dynamic> roommap, int index) {
    return GestureDetector(
      onTap: () {
        print(index);
        _gotoLocation(double.parse(roommap['location'][0]),
            double.parse(roommap['location'][1]));
        _showModal(roommap);
      },
      child: (roommap['img'][0] != null)
          ? Container(
              child: Material(
                color: Global.theme1,
                elevation: 200.0,
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Color(0x802196F3),
                child: Row(children: [
                  Expanded(
                      child:
                          // (roommap['img'][0] != null)
                          //     ?
                          ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      bottomLeft: Radius.circular(24.0),
                    ),
                    child: FadeInImage(
                        fit: BoxFit.fill,
                        placeholder: AssetImage(
                          'assets/loadingif.gif',
                        ),
                        image: NetworkImage(
                          // "check.png"
                          "${roommap['img'][0]}",
                        )),
                  )
                      // : Text('Loading'),
                      ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Room",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Global.theme5),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  "${roommap['numberofroom']}",
                                  style: TextStyle(
                                      fontSize: 16, color: Global.theme5),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Price",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Global.theme5),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  "${roommap['price']}",
                                  style: TextStyle(
                                      fontSize: 16, color: Global.theme5),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Street",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Global.theme5),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text(
                                    "${roommap['street']}",
                                    style: TextStyle(
                                        fontSize: 15, color: Global.theme5),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                BlinkText(
                                  '<<<  Tap to expand.  >>>',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.orange),
                                  endColor: Colors.orange[900],
                                ),
                              ],
                            ),
                          ]),
                    ),
                  )
                ]),
              ),
            )
          : SizedBox(height: 0, width: 0),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        print(query);
        placeList(query);
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {
              setState(() {
                if (count == 3) {
                  count = 0;
                }
                count++;
              });
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
                color: Colors.white,
                elevation: 4.0,
                child:
                    // ListView.builder(
                    //       itemBuilder: (context, index) => ListTile(
                    //         // we will display the data returned from our future here
                    //         title:
                    //             Text(snapshot.data[index]),
                    //         onTap: () {
                    //           close(context, snapshot.data[index]);
                    //         },
                    //       ),
                    //       itemCount: snapshot.data.length,
                    //     )
                    // : Container(child: Text('Loading...')),
                    Container())
            //     Column(
            //   mainAxisSize: MainAxisSize.min,
            //   children: Colors.accents.map((color) {
            //     return Container(height: 112, color: color);
            //   }).toList(),
            // ),
            );
      },
    );
  }
}
