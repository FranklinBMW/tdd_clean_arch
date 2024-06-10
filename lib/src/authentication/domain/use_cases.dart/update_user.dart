import 'package:equatable/equatable.dart';
import 'package:tdd_clean_arch/core/use_case/use_case.dart';
import 'package:tdd_clean_arch/core/utils/typedef.dart';
import 'package:tdd_clean_arch/src/authentication/domain/repositories/authentication_repository.dart';

class UpdateUser extends UseCaseWithParams<void, UpdateUserParams> {
  const UpdateUser(this._repository);
  final AuthenticationRepository _repository;

  @override
  ResultFutureVoid call(UpdateUserParams params) async =>
      _repository.updateUser(
        name: params.userName,
        avatar: params.avatar,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.userName,
    required this.avatar,
  });

  final String userName;
  final String avatar;

  @override
  List<Object?> get props => [userName, avatar];
}
