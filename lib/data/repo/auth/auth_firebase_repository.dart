import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop/data/repo/auth/auth_repo.dart';
import '../../model/user_model.dart';

 class AuthFirebaseRepositoryImpl  extends AuthRepo{
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthFirebaseRepositoryImpl(this._firebaseAuth, this._firestore);


  @override
  Future<bool> resetPasswordAndEmail(String email) async {
    final userCredential =
        await _firebaseAuth.sendPasswordResetEmail(email: email);
    return true;
  }

  @override
  Future<bool> logIn(String email, String password) async {
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user?.uid != null;
  }

  @override
  Future<bool> deleteAccount() async {
    final userCredential = await _firebaseAuth.currentUser?.delete();
    return true;
  }


  @override
  Future<bool> logOut() async {
    await _firebaseAuth.signOut();
    return true;
  }

  @override
  Future<UserModel> profile() async {
      final userUid = _firebaseAuth.currentUser!.uid;
      final user = await _firestore
          .collection(FirestoreKeys.usersCollectionKey)
          .doc(userUid)
          .get();
      return UserModel.fromJson(user.data(), userUid);

  }

  @override
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


