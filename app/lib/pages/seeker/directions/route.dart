import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class RoutePage extends StatefulWidget {
  final dynamic location;
  RoutePage(this.location);

  // final double latitude;
  // final double longitude;
  // const RoutePage(this.latitude, this.longitude);

  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  // Set<Polyline> _polyline = {};
  Map<MarkerId, Marker> markers = {};

  List<LatLng> routeCoords = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyCV87da7EMKy3Y3fUSyup4hMr4Pg9CNhAE";
  // getsomePoints() async {
  //   // var permissions =
  //   //     await Permission.getPermissionsStatus([PermissionName.Location]);
  //   // if (permissions[0].permissionStatus == PermissionStatus.notAgain) {
  //   //   var askpermissions =
  //   //       await Permission.requestPermissions([PermissionName.Location]);
  //   // } else {
  //   routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
  //       origin: LatLng(26.797091768525963, 87.29033879308038),
  //       destination: LatLng(widget.latitude, widget.longitude),
  //       mode: RouteMode.walking);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // getsomePoints();
  //   print(widget.location);
  //   // getCurerntLocation();
  // }

  @override
  void didChangeDependencies() async {
    await getCurerntLocation();
    if (lat != null && long != null) {
      _addMarker(LatLng(lat, long), "origin", BitmapDescriptor.defaultMarker);
    }

    /// destination marker
    _addMarker(
        LatLng(
            double.parse(widget.location[0]), double.parse(widget.location[1])),
        "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
    super.didChangeDependencies();
  }

  // Position post;
  double lat;
  double long;
  void getCurerntLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    final GoogleMapController mapController = await _controller.future;

    setState(() {
      lat = geoposition.latitude;
      long = geoposition.longitude;
    });
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, long), zoom: 17.0)));
  }

  Completer<GoogleMapController> _controller = Completer();

  void onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    // _addPolyLine();
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        // visible: true,
        // width: 4,
        // color: Colors.cyan[300],
        // startCap: Cap.roundCap,
        points: routeCoords);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(lat, long),
      PointLatLng(
          double.parse(widget.location[0]), double.parse(widget.location[1])),
      travelMode: TravelMode.driving,
      // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")
      // ]
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        routeCoords.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
    // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //     googleAPIKey,
    //     // PointLatLng(26.797091768525963, 87.29033879308038),
    //     PointLatLng(lat, long),
    //     PointLatLng(double.parse(widget.location[0]),
    //         double.parse(widget.location[1])));

    // List<PointLatLng> result =
    //     (await polylinePoints?.getRouteBetweenCoordinates(
    //         googleAPIKey,
    //         PointLatLng(lat, long),
    //         PointLatLng(double.parse(widget.location[0]),
    //             double.parse(widget.location[1])))) as List<PointLatLng>;
    // print('Results');
    // print(result.points[0]);
    // print(result.points[1]);
    // print(result);
    // print(result.points);
    // if (result.points.isNotEmpty) {
    //   result.points.forEach((PointLatLng point) {
    //     print("Checking points: ");
    //     print(point.latitude);
    //     print(point.longitude);
    //     routeCoords.add(LatLng(point.latitude, point.longitude));
    //   });
    // }
    // setState(() {
    //   Polyline polyline = Polyline(
    //       polylineId: PolylineId("route"),
    //       visible: true,
    //       width: 4,
    //       color: Colors.cyan[300],
    //       startCap: Cap.roundCap,
    //       points: routeCoords);

    //   // add the constructed polyline as a set of points
    //   // to the polyline set, which will eventually
    //   // end up showing up on the map
    //   _polyline.add(polyline);
    // });
  }

  Map<PolylineId, Polyline> polylines = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Directions')),
        body: GoogleMap(
          onMapCreated: onMapCreated,
          // (GoogleMapController controller) {
          //   _controller.complete(controller);
          // },
          myLocationEnabled: true,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          markers: Set<Marker>.of(markers.values),
          polylines: Set<Polyline>.of(polylines.values),
          initialCameraPosition: CameraPosition(
              target: LatLng(26.797091768525963, 87.29033879308038),
              zoom: 16.0),
          mapType: MapType.normal,
        ));
  }
}
