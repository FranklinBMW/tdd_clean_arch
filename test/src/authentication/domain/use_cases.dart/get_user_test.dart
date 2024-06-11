import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_arch/src/authentication/domain/entities/user_model.dart';
import 'package:tdd_clean_arch/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_clean_arch/src/authentication/domain/use_cases.dart/get_users.dart';

import 'authetication_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late GetUsers useCase;

  setUp(() {
    repository = MockAuthenticationRepository();
    useCase = GetUsers(repository);
  });

  const usersMocked = [UserModel.emptyUser()];

  test('should call [AuthenticationRepository.GetUsers] and return [UserModel]',
      () async {
    //Arrange
    when(
      () => repository.getUsers(),
    ).thenAnswer(
      (_) async => const Right(usersMocked),
    );

    //Act
    final response = await useCase.call();

    //Assert
    expect(response, const Right<dynamic, List<UserModel>>(usersMocked));
    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
