import 'package:tdd_clean_arch/src/authentication/data/models/user_data_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String name,
    required String avatar,
    required String createdAt,
  });

  Future<void> updateUser({
    required String name,
    required String avatar,
  });

  Future<List<UserDataModel>> getUsers();
}
