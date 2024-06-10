import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_arch/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_clean_arch/src/authentication/domain/use_cases.dart/create_user.dart';

// What does the class depends on
// Answer -- Authentication Repository
// How can we create a fake version of the dependency
// Answer -- Use Mocktail
// How do we control what our dependecies do
// Answer -- Using Mocktail APIs

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late CreateUser useCase;
  late AuthenticationRepository repository;

  const params = CreateUserParams.emptyParams();

  setUp(() {
    repository = MockAuthenticationRepository();
    useCase = CreateUser(repository);
  });

  group(
    'create user repository',
    () {
      test(
        'should call the [AuthenticationRepository.createUser]',
        () async {
          //Arrange
          //Stub
          when(
            () => repository.createUser(
              name: any(named: 'name'),
              createdAt: any(named: 'createdAt'),
              avatar: any(named: 'avatar'),
            ),
          ).thenAnswer(
            (_) async => const Right(null),
          );
          //Act
          final result = await useCase.call(params);

          //Assert
          expect(
            result,
            const Right<dynamic, void>(null),
          );

          verify(
            () => repository.createUser(
                name: params.name,
                createdAt: params.createdAt,
                avatar: params.avatar),
          ).called(1);

          verifyNoMoreInteractions(repository);
        },
      );
    },
  );
}
