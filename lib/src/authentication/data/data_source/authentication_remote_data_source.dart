import 'package:tdd_clean_arch/src/authentication/domain/entities/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String name,
    required String avatar,
    required String createdAt,
  });

  Future<void> updateUser({
    required String id,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}
