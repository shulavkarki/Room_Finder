import 'dart:async';

import 'package:app/shared/globals.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/src/types/camera.dart';

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
  @override
  void initState() {
    super.initState();
    // setCustomMarkerIcon();
    gettingRooms();
  }

  // BitmapDescriptor customIcon;

  // void setCustomMarkerIcon() async {
  //   customIcon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(devicePixelRatio: 2.5), 'assets/last.png');
  // }

  void _showModal(Map<String, dynamic> maproom) {
    Future<void> future = showStickyFlexibleBottomSheet<void>(
      minHeight: 0,
      initHeight: 0.5,
      maxHeight: 1,
      headerHeight: 200,
      context: context,
      headerBuilder: (context, offset) {
        return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Global.theme1,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(offset == 0.8 ? 0 : 40),
                topRight: Radius.circular(offset == 0.8 ? 0 : 40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    // child: NetworkImage(
                    //   "${maproom['img'][0]}",
                    // ),
                    child: Hero(
                      tag: "${maproom['roomId']}",
                      child: FadeInImage(
                          fit: BoxFit.fill,
                          placeholder: AssetImage('assets/check.png'),
                          image: (maproom['img'][0] != null)
                              ? NetworkImage("${maproom['img'][0]}")
                              : Image.asset('assets/check.png')),
                    ),
                    //   child: ExtendedNetworkImageProvider(
                    //       roommap['img'][0].tostring()),
                    // ),
                    // style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                // ),
              ],
            ));
      },
      builder: (BuildContext context, double offset) {
        return SliverChildListDelegate(
          <Widget>[
            Text('something'),
          ],
        );
      },
      anchors: [0, 0.5, 1],
    );
    // );
    future.then((void value) => _closeModal(value));
  }

  void _closeModal(void value) {
    print('back.');
  }

  LatLng location;
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
                title: "${room[i]['street']}",
                // snippet: "${room[i]['description'].toString()}"
              ),
              markerId: MarkerId(room[i]['description']),
              position: location,
              onTap: () {
                // _showModal(room[i - 2]);
              }));
          i++;
          // _pageController =
          //     PageController(initialPage: 1, viewportFraction: 0.8)
          //       ..addListener(_onScroll);
        }
      });
    }
  }

  // PageController _pageController;
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
      // bearing: 45.0,
    )));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Container(
          height: height,
          // -50
          width: width,
          child: GoogleMap(
              markers: allMarkers,
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: LatLng(26.797091768525963, 87.29033879308038),
                zoom: 16.0,
                // tilt: 30.0
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              }),
        ),
        (room != null)
            ? Positioned(
                bottom: 15.0,
                child: Container(
                  // color: Colors.cyan[50],
                  height: height * 0.20,
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
                  // PageView.builder(
                  //   controller: _pageController,
                  //   itemCount: room.length,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return _boxes(room[index], index);
                  //   },
                  // ),
                ),
              )
            : SizedBox(width: 0, height: 0),
      ],
    );
  }

  // void _onScroll() {
  //   if (_pageController.page.toInt() != prevPage) {
  //     prevPage = _pageController.page.toInt();
  //   }
  // }

  int prevPage;
  // final List<Widget> imageSliders = room
  //     .map((item) => Container(
  //           child: Container(
  //             margin: EdgeInsets.all(5.0),
  //             child: ClipRRect(
  //                 borderRadius: BorderRadius.all(Radius.circular(5.0)),
  //                 child: Stack(
  //                   children: <Widget>[
  //                     Image.network(item, fit: BoxFit.cover, width: 1000.0),
  //                     Positioned(
  //                       bottom: 0.0,
  //                       left: 0.0,
  //                       right: 0.0,
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                           gradient: LinearGradient(
  //                             colors: [
  //                               Color.fromARGB(200, 0, 0, 0),
  //                               Color.fromARGB(0, 0, 0, 0)
  //                             ],
  //                             begin: Alignment.bottomCenter,
  //                             end: Alignment.topCenter,
  //                           ),
  //                         ),
  //                         padding: EdgeInsets.symmetric(
  //                             vertical: 10.0, horizontal: 20.0),
  //                         child: Text(
  //                           'No. ${imgList.indexOf(item)} image',
  //                           style: TextStyle(
  //                             color: Colors.white,
  //                             fontSize: 20.0,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 )),
  //           ),
  //         ))
  //     .toList();
  Widget _boxes(Map<String, dynamic> roommap, int index) {
    // var size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          print(index);
          _gotoLocation(double.parse(roommap['location'][0]),
              double.parse(roommap['location'][1]));
          _showModal(roommap);
        },
        child: Container(
          child: Material(
            color: Global.theme1,
            elevation: 200.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Color(0x802196F3),
            child: Row(children: [
              Expanded(
                child: Hero(
                  tag: "${roommap['roomId']}",
                  child: ClipRRect(
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
                          "${roommap['img'][0]}",
                        )),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Number of room",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Global.theme5),
                          ),
                          Text(
                            "${roommap['numberofroom']}",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Price",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Global.theme5),
                          ),
                          Text(
                            "${roommap['price']}",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Street",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Global.theme5),
                          ),
                          Expanded(
                            child: Text(
                              "${roommap['street']}",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            ">>Tap here to contact<<",
                            style: TextStyle(
                                fontSize: 12,
                                letterSpacing: 1.5,
                                // fontWeight: FontWeight.bold,
                                color: Colors.orange[200]),
                          ),
                          // Text(
                          //   "${roommap['description'].substring(0, 2)}",
                          //   style: TextStyle(
                          //     fontSize: 10,
                          //   ),
                          // ),
                        ],
                      ),
                    ]),
              )
            ]),
          ),
        ));
    // ation(double.parse(roommap['location'][0]),
    //         double.parse(roommap['location'][1]));
    //     _showModal(roommap);
    //     // _bottomSheet()
    //   },
    //   child: Container(
    //     margin: EdgeInsets.all(5.0),
    //     child: ClipRRect(
    //         borderRadius: BorderRadius.all(Radius.circular(5.0)),
    //         child: Stack(
    //           children: <Widget>[
    //             Image.network(roommap['img'][0],
    //                 fit: BoxFit.cover, width: 1000.0),
    //             Positioned(
    //               bottom: 0.0,
    //               left: 0.0,
    //               right: 0.0,
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                   gradient: LinearGradient(
    //                     colors: [
    //                       Color.fromARGB(200, 0, 0, 0),
    //                       Color.fromARGB(0, 0, 0, 0)
    //                     ],
    //                     begin: Alignment.bottomCenter,
    //                     end: Alignment.topCenter,
    //                   ),
    //                 ),
    //                 padding:
    //                     EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    //                 child: Text(
    //                   'No.  image',
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                     fontSize: 20.0,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         )),
    //   ),
    // );
    // }
    // Widget _boxes(Map<String, dynamic> roommap, index) {
    //   double height = MediaQuery.of(context).size.height;
    //   double width = MediaQuery.of(context).size.width;
    //   return AnimatedBuilder(
    //     animation: _pageController,
    //     builder: (BuildContext context, Widget widget) {
    //       double value = 1;
    //       if (_pageController.position.haveDimensions) {
    //         value = _pageController.page - index;
    //         value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
    //       }
    //       return Center(
    //         child: SizedBox(
    //           height: Curves.easeInOut.transform(value) * height * .20,
    //           width: Curves.easeInOut.transform(value) * width * .80,
    //           child: widget,
    //         ),
    //       );
    //     },
    //     child: GestureDetector(
    //         onTap: () {
    //           _gotoLocation(double.parse(roommap['location'][0]),
    //               double.parse(roommap['location'][1]));
    //           _showModal(roommap);
    //           // _bottomSheet()
    //         },
    //         child: Container(
    //             // margin: EdgeInsets.symmetric(
    //             //   horizontal: 10.0,
    //             //   vertical: 10.0,
    //             // ),
    //             // height: 300,
    //             // width: 275.0,
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(20.0),
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.black54,
    //                     offset: Offset(0.0, 4.0),
    //                     blurRadius: 20.0,
    //                   ),
    //                 ]),
    //             child: Row(children: [
    //               Expanded(
    //                 child: Container(
    //                     child: Hero(
    //                       tag: "${roommap['roomId']}",
    //                       child: FadeInImage(
    //                         // height: ScreenUtil.instance.setHeight(330),
    //                         fit: BoxFit.fill,
    //                         placeholder: AssetImage('assets/load.jpg'),
    //                         image: NetworkImage(
    //                           "${roommap['img'][0]}",
    //                         ),
    //                       ),
    //                       // child: ExtendedNetworkImageProvider(
    //                       //     roommap['img'][0].tostring()),
    //                     ),
    //                     width: width * 0.3,
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.only(
    //                           bottomLeft: Radius.circular(20.0),
    //                           topLeft: Radius.circular(20.0)),
    //                       // image: DecorationImage(
    //                       //     image: (roommap['img'][0] != null)
    //                       //         ? NetworkImage(roommap['img'][0])
    //                       //         : Image.asset('assets/loadingImage.jpg'),
    //                       //     fit: BoxFit.cover)
    //                     )),
    //               ),
    //               Expanded(
    //                 child: Container(
    //                   color: Colors.cyan,
    //                   child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           "${roommap['numberofroom']}",
    //                           style: TextStyle(
    //                               fontSize: 12.5, fontWeight: FontWeight.bold),
    //                         ),
    //                         Text(
    //                           roommap['street'],
    //                           style: TextStyle(
    //                               fontSize: 12.0, fontWeight: FontWeight.w600),
    //                         ),
    //                         Text(
    //                           roommap['description'],
    //                           style: TextStyle(
    //                               fontSize: 11.0, fontWeight: FontWeight.w300),
    //                         )
    //                       ]),
    //                 ),
    //               )
    //             ]))),
    //   );
    // }
  }
}
