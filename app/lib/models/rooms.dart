class RoomModel {
  final String roomId;
  final int price;
  final int phone;
  final int numberofroom;
  final List location;
  final String street;
  final List<dynamic> images;
  final String description;
  final String gender;
  final List<dynamic> neccessity;
  bool published;

  // final List option;
  final String userId;

  RoomModel(
      this.roomId,
      this.price,
      this.phone,
      this.numberofroom,
      this.location,
      this.street,
      this.images,
      this.description,
      this.gender,
      this.neccessity,
      this.published,
      this.userId);
// String uid
  // List get option => null;

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'price': price,
      'phone': phone,
      'numberofroom': numberofroom,
      'location': location,
      'street': street,
      // 'images': images,
      'description': description,
      'gender': gender,
      'neccessity': neccessity,
      'published': true,
      // 'option' : option,
      'userId': userId,
    };
  }

  RoomModel.fromFirestore(Map firestore)
      : roomId = firestore['roomId'],
        price = firestore['price'],
        phone = firestore['phone'],
        numberofroom = firestore['numberofroom'],
        location = firestore['location'],
        street = firestore['street'],
        images = firestore[''],
        description = firestore['description'],
        gender = firestore['gender'],
        neccessity = firestore['neccessity'],
        published = firestore['published'],
        userId = firestore['userId'];
}
