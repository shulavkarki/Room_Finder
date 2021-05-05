import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';

class AuthenticationProvider {
  final FirebaseAuth firebaseAuth;
  // final FirestoreService firestoreService;
  //FirebaseAuth instance
  AuthenticationProvider(this.firebaseAuth);
  //Constuctor to initalize the FirebaseAuth instance
  // FirebaseFirestore _db = FirebaseFirestore.instance;

  //Using Stream to listen to Authentication State
  Stream<User> get authState => firebaseAuth.idTokenChanges();
  String email;
  String uid;
  //............RUDIMENTARY METHODS FOR AUTHENTICATION................
  Future<String> onStartup() async {
    String retVal = "error";
    try {
      final
          // final firebaseUser = Provider.of<User>(context, listen: false);
          _firebaseUser = await firebaseAuth.currentUser;
      if (_firebaseUser.uid != null) {
        retVal = 'success';
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  //SIGN UP METHOD
  Future<String> signUp({String email, String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = firebaseAuth.currentUser;
      print(user.email);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({'email': user.email});
      return "Signed up!";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future<String> signIn({String email, String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // var user = firebaseAuth.currentUser;
      // firestoreService.saveRoom(RoomModel room, user.uid);
      return "Signed in!";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
