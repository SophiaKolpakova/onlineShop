import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user.dart';

 class AuthRepositoryImpl {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepositoryImpl(this._firebaseAuth, this._firestore);


  Future<bool> resetPasswordAndEmail(String email) async {
    final userCredential =
        await _firebaseAuth.sendPasswordResetEmail(email: email);
    return true;
  }


  Future<bool> deleteAccount() async {
    final userCredential = await _firebaseAuth.currentUser?.delete();
    return true;
  }


  Future<bool> logOut() async {
    final userCredential = await _firebaseAuth.signOut();
    return true;
  }

  Future<UserModel> profile() async {
      final userUid = _firebaseAuth.currentUser!.uid;
      final user = await _firestore
          .collection(FirestoreKeys.usersCollectionKey)
          .doc(userUid)
          .get();
      return UserModel.fromJson(user.data(), userUid);

  }

  Future<bool> signUp(
    String name,
    String email,
    String password,
  ) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    _firestore
        .collection(FirestoreKeys.usersCollectionKey)
        .doc(userCredential.user!.uid)
        .set({
      FirestoreKeys.emailFieldKey: email,
      FirestoreKeys.nameFieldKey: name,
    });
    return userCredential.user?.uid != null;
  }


}

class FirestoreKeys {
  static const String usersCollectionKey = "users";
  static const String emailFieldKey = "email";
  static const String nameFieldKey = "first_name";
}


