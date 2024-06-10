import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_arch/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_clean_arch/src/authentication/domain/use_cases.dart/update_user.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late MockAuthenticationRepository repository;
  late UpdateUser useCase;

  setUp(() {
    repository = MockAuthenticationRepository();
    useCase = UpdateUser(repository);
  });

  group(
    'update_user_test',
    () {
      final params = UpdateUserParams.empty();

      test(
        'should call [Authentication.updateUser]',
        () async {
          // arrange
          when(
            () => repository.updateUser(
              name: any(named: 'name'),
              avatar: any(named: 'avatar'),
            ),
          ).thenAnswer(
            (_) async => const Right(null),
          );

          // act
          final result = await useCase.call(params);

          // assert
          expect(
            result,
            const Right<dynamic, void>(null),
          );

          verify(
            () => repository.updateUser(
                name: params.userName, avatar: params.avatar),
          ).called(1);

          verifyNoMoreInteractions(repository);
        },
      );
    },
  );
}
