import 'package:tdd_clean_arch/core/use_case/use_case.dart';
import 'package:tdd_clean_arch/core/utils/typedef.dart';
import 'package:tdd_clean_arch/src/authentication/domain/entities/user_model.dart';
import 'package:tdd_clean_arch/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UseCaseWithoutParams<List<UserModel>> {
  const GetUsers(this._repository);
  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<UserModel>> call() async => await _repository.getUsers();
}
