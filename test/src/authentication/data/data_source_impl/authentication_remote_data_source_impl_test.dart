import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_arch/core/errors/exceptions.dart';
import 'package:tdd_clean_arch/core/utils/constants.dart';
import 'package:tdd_clean_arch/src/authentication/data/data_source/authentication_remote_data_source.dart';
import 'package:tdd_clean_arch/src/authentication/data/data_source_impl/authentication_remote_data_source_impl.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;
  const johnDoe = {
    "name": "John Doe",
    "avatar": "https://example.com/avatar.jpg",
    "createdAt": "2023-03-08T12:00:00.000Z",
  };

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthenticationRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group(
    'AuthenticationRemoteDataSourceImpl.createUser',
    () {
      test(
        'should complete successfully and return 200 as statusCode when called [createUser] and request is successful',
        () async {
          // Arrange
          when(() => client.post(
                any(),
                body: any(named: 'body'),
              )).thenAnswer(
            (_) async => http.Response(
              jsonEncode(johnDoe),
              200,
            ),
          );

          // Act
          final methodCall = remoteDataSource.createUser;

          // Assert
          await expectLater(
            methodCall(
              name: 'John Doe',
              avatar: 'https://example.com/avatar.jpg',
              createdAt: '2023-03-08T12:00:00.000Z',
            ),
            completes,
          );

          verify(
            () => client.post(
              Uri.parse('$kBaseUrl$kPostUsersRequestEndpoint'),
              body: jsonEncode(johnDoe),
            ),
          ).called(1);

          verifyNoMoreInteractions(client);
        },
      );

      test(
        'should throw a [ApiException] when called [createUser] and request is unsuccessful',
        () async {
          // Arrange
          when(() => client.post(
                any(),
                body: any(named: 'body'),
              )).thenAnswer(
            (_) async => http.Response(
              "Something went wrong",
              400,
            ),
          );

          // Act
          final methodCall = remoteDataSource.createUser(
            avatar: 'avatar',
            name: 'name',
            createdAt: 'createdAt',
          );

          // Assert
          expect(
            () async => methodCall,
            throwsA(
              const ApiException(
                message: "Something went wrong",
                statusCode: 400,
              ),
            ),
          );

          verify(
            () => client.post(
              Uri.parse('$kBaseUrl$kPostUsersRequestEndpoint'),
              body: jsonEncode(
                {
                  "name": "name",
                  "avatar": "avatar",
                  "createdAt": "createdAt",
                },
              ),
            ),
          ).called(1);

          verifyNoMoreInteractions(client);
        },
      );
    },
  );

  group(
    'AuthenticationRemoteDataSourceImpl.getUsers',
    () {
      test(
        'should complete successfully and return 200 as statusCode when called [getUsers] and request is successful',
        () async {
          // Arrange
          when(() => client.get(
                any(),
                headers: any(named: 'headers'),
              )).thenAnswer(
            (_) async => http.Response(
                '[{"name": "John Doe", "avatar": "https://example.com/avatar.jpg", "createdAt": "2023-03-08T12:00:00.000Z"}]',
                200),
          );

          // Act

          // Act
          // Assert
        },
      );
    },
  );
}
