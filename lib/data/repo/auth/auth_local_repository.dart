import 'package:shop/data/repo/auth/auth_repo.dart';
import '../../model/user_model.dart';

 class AuthLocalRepositoryImpl extends AuthRepo {

  @override
  Future<bool> resetPasswordAndEmail(String email) async {
   return true;
  }

  @override
  Future<bool> logIn(String email, String password) async {
   return true;
  }

  @override
  Future<bool> deleteAccount() async {
   return true;
  }

  @override
  Future<bool> logOut() async {
   return true;
  }

  @override
  Future<UserModel> profile() async {
   return UserModel.empty();
  }

  @override
  Future<bool> signUp(
      String name,
      String email,
      String password,
      ) async {
   return true;
  }
}


