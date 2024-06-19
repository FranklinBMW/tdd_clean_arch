import 'dart:convert';

import 'package:tdd_clean_arch/core/errors/exceptions.dart';
import 'package:tdd_clean_arch/core/utils/constants.dart';
import 'package:tdd_clean_arch/src/authentication/data/data_source/authentication_remote_data_source.dart';
import 'package:tdd_clean_arch/src/authentication/domain/entities/user_model.dart';
import 'package:http/http.dart' as http;

const kGetUsersRequestEndpoint = '/users';
const kPostUsersRequestEndpoint = '/users';
const kPutUsersRequestEndpoint = '/users';

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  // Test Driven Development
  // 1. Write a test
  // Check to ensure that request will return the correct data if response is 200
  // 2. Check to ensure that request throws a custom exception if response is not 200
  // 3. Implement the functionality

  const AuthenticationRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser({
    required String name,
    required String avatar,
    required String createdAt,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kPostUsersRequestEndpoint'),
        body: jsonEncode(
          {
            'name': name,
            'avatar': avatar,
            'createdAt': createdAt,
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }

  @override
  Future<void> updateUser({
    required String id,
    required String name,
    required String avatar,
  }) async {
    try {
      final response = await _client.put(
        Uri.parse('$kBaseUrl$kPutUsersRequestEndpoint/$id'),
        body: jsonEncode(
          {
            'name': name,
            'avatar': avatar,
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }

  @override
  Future<List<UserModel>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
