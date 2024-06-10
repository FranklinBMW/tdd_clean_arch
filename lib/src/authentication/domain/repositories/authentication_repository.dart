import 'package:tdd_clean_arch/core/utils/typedef.dart';
import 'package:tdd_clean_arch/src/authentication/domain/entities/user_model.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFutureVoid createUser({
    required String name,
    required String createdAt,
    required String avatar,
  });

  ResultFutureVoid updateUser({
    required String name,
    required String avatar,
  });

  ResultFuture<List<UserModel>> getUsers();
}
