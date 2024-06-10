import 'package:equatable/equatable.dart';
import 'package:tdd_clean_arch/core/use_case/use_case.dart';
import 'package:tdd_clean_arch/core/utils/typedef.dart';
import 'package:tdd_clean_arch/src/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UseCaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFutureVoid call(CreateUserParams params) async {
    return await _repository.createUser(
      name: params.name,
      avatar: params.avatar,
      createdAt: params.createdAt,
    );
  }
}

class CreateUserParams extends Equatable {
  const CreateUserParams({
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  final String name;
  final String avatar;
  final String createdAt;

  const CreateUserParams.emptyParams()
      : this(
          name: '',
          avatar: '',
          createdAt: '',
        );

  @override
  List<Object?> get props => [name, avatar, createdAt];
}
