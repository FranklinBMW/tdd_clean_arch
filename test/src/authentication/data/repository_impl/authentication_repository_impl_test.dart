import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_arch/core/errors/exceptions.dart';
import 'package:tdd_clean_arch/core/errors/failure.dart';
import 'package:tdd_clean_arch/src/authentication/data/data_source/authentication_remote_data_source.dart';
import 'package:tdd_clean_arch/src/authentication/data/repository_impl/authentication_repository_impl.dart';

class MockAuthenticationRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource mockRemoteDataSource;
  late AuthenticationRepositoryImpl repositoryImpl;

  setUp(() {
    mockRemoteDataSource = MockAuthenticationRemoteDataSource();
    repositoryImpl = AuthenticationRepositoryImpl(mockRemoteDataSource);
  });

  const tException =
      ApiException(message: 'Unknown Error Occurred', statusCode: 500);

  const String name = 'user.Name';
  const String avatar = 'user.Avatar';
  const String createdAt = 'user.CreatedAt';

  group(
    'AuthenticationRemoteDataSource.createUser',
    () {
      test(
        'should call [createUser] method of [AuthenticationRemoteDataSource] and complete successfully when the call is successful',
        () async {
          // Arrange
          when(
            () => mockRemoteDataSource.createUser(
              name: any(named: 'name'),
              avatar: any(named: 'avatar'),
              createdAt: any(named: 'createdAt'),
            ),
          ).thenAnswer(
            //returning void
            (_) async => Future.value(),
          );

          // Act
          final result = await repositoryImpl.createUser(
            name: name,
            avatar: avatar,
            createdAt: createdAt,
          );

          // Assert
          expect(result, equals(const Right(null)));
          verify(
            () => mockRemoteDataSource.createUser(
              name: name,
              avatar: avatar,
              createdAt: createdAt,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockRemoteDataSource);
        },
      );

      test(
        'should return an [ApiFailure] when the call to the remote source is unsuccessful',
        () async {
          // Arrange
          when(
            () => mockRemoteDataSource.createUser(
              name: any(named: 'name'),
              avatar: any(named: 'avatar'),
              createdAt: any(named: 'createdAt'),
            ),
          ).thenThrow(tException);
          // Act
          final result = await repositoryImpl.createUser(
            name: name,
            avatar: avatar,
            createdAt: createdAt,
          );
          // Assert
          expect(
            result,
            equals(
              Left(
                ApiFailure(
                  message: tException.message,
                  statusCode: tException.statusCode,
                ),
              ),
            ),
          );
          verify(
            () => mockRemoteDataSource.createUser(
                name: name, avatar: avatar, createdAt: createdAt),
          ).called(1);
          verifyNoMoreInteractions(mockRemoteDataSource);
        },
      );
    },
  );
}
