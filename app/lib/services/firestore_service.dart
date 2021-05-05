import 'package:app/models/rooms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FirestoreService extends ChangeNotifier {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  // CollectionReference imgRef;

  // Future<void> saveRoom(RoomModel room) {
  //   // var user = firebaseAuth.currentUser;
  //   return _db.collection('rooms').doc(room.roomId).set(room.toMap());
  // }

  Future<List<void>> saveRoom(RoomModel room) async {
    // var user = firebaseAuth.currentUser;
    var roomId = room.roomId;
    print(roomId);
    return await Future.value(
        [uploadRoom(room), uploadFile(room.images, roomId)]);
  }

  uploadRoom(RoomModel room) {
    _db.collection('rooms').doc(room.roomId).set(room.toMap());
  }

  uploadFile(List<dynamic> _image, String roomId) {
    int i = 0;
    int uploaded = 0;
    DocumentReference imgRef;
    List<String> imageUrls = [];
    imgRef = FirebaseFirestore.instance.collection('rooms').doc(roomId);
    FirebaseStorage storage = FirebaseStorage.instance;
    var user = firebaseAuth.currentUser;
    print(_image);
    for (var img in _image) {
      Reference ref = storage.ref().child('${user.uid}/${roomId}/${i}');
      ref.putFile(img).whenComplete(() {
        ref.getDownloadURL().then((value) {
          imageUrls.add(value);
          if (uploaded == _image.length - 1) {
            imgRef.update({
              'img': imageUrls,
            });
          }
          uploaded++;
        });
      });
      i++;
    }
  }

  Stream<List<RoomModel>> getRooms() {
    User user = firebaseAuth.currentUser;
    // user.reload();
    return _db
        .collection('rooms')
        .where("userId", isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => RoomModel.fromFirestore(document.data()))
            .toList());
  }

  Stream<List<RoomModel>> getAllRooms() {
    return _db
        .collection('rooms')
        .where("published", isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => RoomModel.fromFirestore(document.data()))
            .toList());
  }

  Future removeRoom(String roomId) {
    return _db.collection('rooms').doc(roomId).delete();
  }
}
