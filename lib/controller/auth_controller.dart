import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_kuliner_app/model/user_model.dart';

class AuthController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  bool get succes => false;

  Future<UserModel?> registeremailPassword(
      String email, String password, String username) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? user = userCredential.user;

      if (user != null) {
        final UserModel newUser = UserModel(
          username: username,
          email: user.email ?? '',
          uid: user.uid,
        );

        await userCollection.doc(newUser.uid).set(newUser.toMap());

        return newUser;
      }
    } catch (e) {
      print('Error registering user: $e');
    }
  }

  Future<UserModel?> signEmailandPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot snapshot =
            await userCollection.doc(user.uid).get();

        final UserModel currentUser = UserModel(
          username: snapshot['username'] ?? '',
          email: user.email ?? '',
          uid: user.uid,
        );

        return currentUser;
      }
    } catch (e) {
      print('Error signing in: $e');
    }

    return null;
  }

  /// Method untuk logout dari acccount FirebaseAuth
  Future<void> signOut() async {
    await auth.signOut();
  }
}
