import 'dart:async';
import 'package:app/models/rooms.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:app/provider/room_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class AddRoom extends StatefulWidget {
  final RoomModel room;
  AddRoom([this.room]);

  @override
  _AddRoomState createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  // final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  final priceController = TextEditingController();
  final phoneController = TextEditingController();
  final numberofroomController = TextEditingController();
  final descriptionController = TextEditingController();
  String longitude = "";
  String latitude = "";
  LatLng location;
  List<dynamic> images = [];
  List<Marker> myMarker = [];
  String _currentAddress;
  // GoogleMapController _controller;

  // @override
  void disopse() {
    priceController.dispose();
    descriptionController.dispose();
    numberofroomController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  //inserted async
  _handleTap(LatLng tappedPoint) async {
    setState(() {
      myMarker = [];
      latitude = tappedPoint.latitude.toString();
      longitude = tappedPoint.longitude.toString();
      _getAddressFromLatLng();
      print(tappedPoint);
      myMarker.add(Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          draggable: true,
          onDragEnd: (dragEndPosition) {
            print(dragEndPosition);
          }));
    });
    await _getAddressFromLatLng();
  }

  _getAddressFromLatLng() async {
    try {
      double latitude = double.parse(this.latitude);
      double longitude = double.parse(this.longitude);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = "${place.street}, ${place.locality},";
      });
    } catch (e) {
      print(e);
      print('not working');
    }
  }

  void onMapCreated(controller) {
    _controller = controller;
  }

  getCurrentLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    final GoogleMapController mapController = await _controller.future;
    // print(geoposition);
    setState(() {
      myMarker = [];
      latitude = '${geoposition.latitude}';
      longitude = '${geoposition.longitude}';
      _getAddressFromLatLng();
      location = new LatLng(double.parse(latitude), double.parse(longitude));
      print('LOcation:');
      print(location);
      myMarker.add(Marker(
          markerId: MarkerId(location.toString()),
          position: location,
          draggable: true,
          onDragEnd: (dragEndPosition) {
            print(dragEndPosition);
          }));

      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: location, zoom: 17.0)));
    });
  }

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  // @override
  // void initState() {
  //   // getCurrentLocation();
  //   if (widget.room == null) {
  //     //New Record
  //     priceController.text = "";
  //     phoneController.text = "";
  //     numberofroomController.text = "";
  //     descriptionController.text = "";
  //     // _fbKey.currentState.value['choice_chip'] = '';
  //     new Future.delayed(Duration.zero, () {
  //       final roomProvider = Provider.of<RoomProvider>(context, listen: false);
  //       // RoomModel room = RoomModel();
  //       roomProvider.loadValues(widget.room);
  //     });
  //   }
  //   // else {
  //   //   //Controller Update
  //   //   priceController.text = widget.room.price.toString();
  //   //   phoneController.text = widget.room.phone.toString();
  //   //   numberofroomController.text = widget.room.numberofroom.toString();
  //   //   descriptionController.text = widget.room.description;
  //   //   // _fbKey.currentState.value['choice_chip'] = widget.room.
  //   //   //State Update
  //   //   new Future.delayed(Duration.zero, () {
  //   //     final roomProvider = Provider.of(context, listen: false);
  //   //     roomProvider.loadValues(widget.room);
  //   //   });
  //   // }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final roomProvider = Provider.of<RoomProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Add the room"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: FormBuilder(
              key: _fbKey,
              initialValue: {
                'date': DateTime.now(),
                'accept_terms': false,
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FormBuilderTextField(
                    controller: numberofroomController,
                    name: 'room',
                    decoration: InputDecoration(
                      labelText: 'No. of room',
                      prefixIcon: Icon(Icons.house),
                      fillColor: Colors.grey[100],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide:
                            BorderSide(color: Colors.cyan[500], width: 1.5),
                      ),
                    ),
                    onChanged: (value) {
                      roomProvider.changeNumberofroom(value);
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.max(context, 10),
                    ]),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                    controller: priceController,
                    name: 'price',
                    decoration: InputDecoration(
                      labelText: 'Price',
                      prefixIcon: Icon(Icons.attach_money_outlined),
                      fillColor: Colors.grey[100],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide:
                            BorderSide(color: Colors.cyan[500], width: 1.5),
                      ),
                    ),
                    onChanged: (value) {
                      roomProvider.changePrice(value);
                    },
                    valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.numeric(context),
                    ]),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderTextField(
                    controller: phoneController,
                    name: "phone",
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      prefixIcon: Icon(Icons.contact_phone),
                      fillColor: Colors.grey[100],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide:
                            BorderSide(color: Colors.cyan[500], width: 1.5),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.maxLength(context, 10),
                    ]),
                    onChanged: (value) {
                      roomProvider.changePhone(value);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormBuilderDropdown(
                    name: "gender",
                    onChanged: (value) {
                      roomProvider.changeGender(value.toString());
                      print('Getting gender');
                      print(value.toString());
                    },
                    decoration: InputDecoration(
                      labelText: "Gender",
                      prefixIcon: Icon(Icons.person_add_alt),
                      fillColor: Colors.grey[100],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide:
                            BorderSide(color: Colors.cyan[500], width: 1.5),
                      ),
                    ),
                    // initialValue: 'Both',
                    hint: Text('Select Gender'),
                    allowClear: true,
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    items: ['Male', 'Female', 'Both']
                        .map((gender) => DropdownMenuItem(
                            value: gender, child: Text("$gender")))
                        .toList(),
                  ),
                  const SizedBox(height: 15),
                  FormBuilderFilterChip(
                    onChanged: (value) {
                      roomProvider.changeNeccessity(value);
                    },
                    name: 'choice_chip',
                    decoration: InputDecoration(
                        labelText: 'Select based on the availability.',
                        labelStyle: TextStyle(fontSize: 20)),
                    selectedColor: Theme.of(context).primaryColor,
                    options: [
                      FormBuilderFieldOption(
                        value: 'wifi',
                        child: Text('Wifi?',
                            style: TextStyle(fontSize: 20, letterSpacing: 2)),
                      ),
                      FormBuilderFieldOption(
                          value: 'parking',
                          child: Text('Parking?',
                              style:
                                  TextStyle(fontSize: 20, letterSpacing: 2))),
                      FormBuilderFieldOption(
                          value: 'water',
                          child: Text('Water?',
                              style:
                                  TextStyle(fontSize: 20, letterSpacing: 2))),
                      FormBuilderFieldOption(
                          value: 'kitchen',
                          child: Text('Kitchen?',
                              style:
                                  TextStyle(fontSize: 20, letterSpacing: 2))),
                    ],
                  ),
                  const SizedBox(height: 20),
                  FormBuilderTextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: "Description",
                      fillColor: Colors.grey[100],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.cyan[500], width: 1.5),
                      ),
                    ),
                    onChanged: (value) {
                      roomProvider.changeDescription(value);
                    },
                    name: 'name',
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: FormBuilderImagePicker(
                      // initialValue: images,
                      onChanged: (value) {
                        roomProvider.changeImage(value);
                      },
                      imageQuality: 25,
                      previewHeight: 130,
                      previewWidth: width * 0.25,
                      name: 'photos',
                      validator: FormBuilderValidators.required(context),
                      decoration: const InputDecoration(
                        labelText: 'Pick Photos',
                        labelStyle: TextStyle(fontSize: 19, letterSpacing: 1.6),
                      ),
                      maxImages: 5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(
                          'Mark the house or mark the street or use current location if youre around the house. ',
                          // 'Mark the house in Map or Use your current location if you re on the current vacant room location by clickin on the buttom which is in the bottom left corner.',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 350,
                    child: Stack(
                      children: [
                        GoogleMap(
                            mapToolbarEnabled: true,
                            tiltGesturesEnabled: true,
                            mapType: MapType.hybrid,
                            compassEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target:
                                  LatLng(26.797091768525963, 87.29033879308038),
                              zoom: 16,
                            ),
                            onTap: _handleTap,
                            markers: Set.from(myMarker),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            gestureRecognizers: Set()
                              ..add(Factory<EagerGestureRecognizer>(
                                  () => EagerGestureRecognizer()))),
                        Container(
                          padding: EdgeInsets.all(4),
                          alignment: Alignment.bottomLeft,
                          child: ClipOval(
                            child: Material(
                              color: Colors.grey[300],
                              child: InkWell(
                                splashColor: Colors.cyan,
                                child: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.cyan,
                                      size: 30,
                                    )),
                                onTap: () async {
                                  await getCurrentLocation();
                                  roomProvider.changeLocation(
                                      latitude, longitude);
                                  roomProvider.changeStreet(_currentAddress);
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text('Address of Room:'),
                  Text(_currentAddress.toString()),
                  const SizedBox(height: 30),
                  FormBuilderCheckbox(
                    name: 'accept_terms',
                    initialValue: false,
                    checkColor: Theme.of(context).primaryColor,
                    activeColor: Colors.white,
                    title: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 13),
                        children: [
                          TextSpan(
                            text: 'I have read and agree to the ',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: TextStyle(color: Colors.blue[400]),
                          ),
                        ],
                      ),
                    ),
                    validator: FormBuilderValidators.equal(
                      context,
                      true,
                      errorText:
                          'You must accept terms and conditions to continue',
                    ),
                  ),
                  const SizedBox(height: 15),
                  MaterialButton(
                    child: Text('Submit'),
                    color: Colors.cyan,
                    onPressed: () async {
                      _fbKey.currentState.save();
                      if (_fbKey.currentState.validate()) {
                        if (this.latitude != null &&
                            this.longitude != null &&
                            this._currentAddress != null) {
                          roomProvider.changeLocation(latitude, longitude);
                          roomProvider.changeStreet(_currentAddress);
                          roomProvider.addRoom();
                          Navigator.pop(context, true);
                          Flushbar(
                            message: "Saved!",
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.green,
                          )..show(context);
                        }
                        // else {
                        //   print('this is running.');
                        //    roomProvider.changeLocation(
                        //       latitude, longitude);
                        //   print('2nd running.');
                        //   roomProvider.addRoom();
                        //   Navigator.pop(context);
                        // }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          (widget.room != null)
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: Text("Delete"),

                  // color: Colors.red,
                  onPressed: () {
                    roomProvider.removeRoom(widget.room.roomId);
                    Navigator.of(context).pop();
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}

class FormBuilderMapField {}
