import 'package:shop/data/model/user_model.dart';

abstract class AuthRepo {
  Future<bool> resetPasswordAndEmail(String email);

  Future<bool> logIn(String email, String password);

  Future<bool> deleteAccount();

  Future<bool> logOut();

  Future<UserModel> profile();

  Future<bool> signUp(
    String name,
    String email,
    String password,
  );
}
