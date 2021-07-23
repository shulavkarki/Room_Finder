// import 'dart:io';

import 'package:app/models/rooms.dart';
import 'package:app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class RoomProvider extends ChangeNotifier {
  final firestoreService = FirestoreService();
  int _price;
  int _phone;
  int _numberofroom;
  List _location;
  String _street;
  List<dynamic> _images;
  String _description;
  List<dynamic> _neccessity;
  String _gender;
  String _roomId;
  bool _published;
  dynamic _time;
  var uuid = Uuid();

  //GETTERS
  int get price => _price;
  int get numberofroom => _numberofroom;
  int get phone => _phone;
  List get location => _location;
  String get street => _street;
  List<dynamic> get images => _images;
  String get description => _description;
  String get gender => _gender;
  bool get published => _published;
  List<dynamic> get neccessity => _neccessity;
  dynamic get time => _time;
  String get roomId => _roomId;

  //SETTERS

  void changePrice(String value) {
    _price = int.parse(value);
    notifyListeners();
  }

  void changeDateTime(dynamic value) {
    _time = value;
    notifyListeners();
  }

  void changePhone(String value) {
    _phone = int.parse(value);
    notifyListeners();
  }

  void changeNumberofroom(String value) {
    _numberofroom = int.parse(value);
    notifyListeners();
  }

  void changeLocation(String latitude, String longitude) {
    _location = [latitude, longitude];
    notifyListeners();
  }

  void changeStreet(String value) {
    _street = value;
    notifyListeners();
  }

  void changeImage(List<dynamic> value) {
    _images = value;
    notifyListeners();
  }

  void changeDescription(value) {
    _description = value;
    notifyListeners();
  }

  void changeGender(value) {
    _gender = value;
    notifyListeners();
  }

  void changeNeccessity(List value) {
    _neccessity = value;
    notifyListeners();
  }

  void loadValues(RoomModel room) {
    _price = room.price;
    _numberofroom = room.numberofroom;
    _phone = room.phone;
    _location = room.location;
    _street = room.street;
    _images = room.images;
    _description = room.description;
    _gender = room.gender;
    _neccessity = room.neccessity;
    _published = room.published;
    _time = room.time;
    // _option = room.option;
    _roomId = room.roomId;
  }

  void saveRoom() {
    final firebaseAuth = FirebaseAuth.instance;
    var user = firebaseAuth.currentUser;
    debugPrint("Values: $_roomId $_price ");
    if (_roomId == null) {
      var newRoom = RoomModel(
          uuid.v4(),
          price,
          phone,
          numberofroom,
          location,
          street,
          images,
          description,
          gender,
          neccessity,
          true,
          time,
          user.uid);
      firestoreService.saveRoom(newRoom);
    } else {
      //Update
      var updateRoom = RoomModel(
          _roomId,
          _price,
          _phone,
          _numberofroom,
          _location,
          _street,
          _images,
          _description,
          _gender,
          _neccessity,
          _published,
          _time,
          user.uid);
      firestoreService.saveRoom(updateRoom);
    }
  }

  void removeRoom(String roomId) {
    firestoreService.removeRoom(roomId);
  }

  void addRoom() {
    final firebaseAuth = FirebaseAuth.instance;
    var user = firebaseAuth.currentUser;
    var newRoom = RoomModel(uuid.v4(), price, phone, numberofroom, location,
        street, images, description, gender, neccessity, true, time, user.uid);
    firestoreService.saveRoom(newRoom);
  }
}
