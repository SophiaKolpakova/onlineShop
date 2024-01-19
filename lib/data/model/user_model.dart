import '../repo/auth/auth_firebase_repository.dart';

class UserModel {
  String user_id;
  String user_name;
  String user_email;

  UserModel(this.user_id, this.user_name, this.user_email);

  UserModel.empty()
      : user_email = '',
        user_id = '',
        user_name = '';

  UserModel.fromJson(dynamic data, this.user_id)
      : user_name = data[FirestoreKeys.nameFieldKey] ?? '',
        user_email = data[FirestoreKeys.emailFieldKey] ?? '';

  Map<String, dynamic> toJson() => {
        'user_id': user_id,
        'user_name': user_name,
        'user_email': user_email,
      };
}
