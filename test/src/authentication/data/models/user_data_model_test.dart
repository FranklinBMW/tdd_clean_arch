import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/core/utils/typedef.dart';
import 'package:tdd_clean_arch/src/authentication/data/models/user_data_model.dart';
import 'package:tdd_clean_arch/src/authentication/domain/entities/user_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserDataModel.emptyUser();

  final userJson = fixture('single_user.json');
  final userMap = json.decode(userJson) as DataMap;

  final userListJson = fixture('users.json');
  final userListMap = json.decode(userListJson) as List<dynamic>;

  final usersList = [];

  setUpAll(() {
    for (final dynamic item in userListMap) {
      if (item is DataMap) {
        usersList.add(UserDataModel.fromMap(item));
      }
    }
  });

  test('should be a subClass of [UserModel] entity', () async {
    // Arrange

    // Act

    // Assert
    expect(tModel, isA<UserModel>());
  });
  group(
    'UserDataModel fromMap',
    () {
      test(
        'should return a [UserDataModel] with the right data',
        () async {
          //Arrange

          //Act
          final result = UserDataModel.fromMap(userMap);

          //Assert
          expect(result, tModel);
        },
      );

      test('should return a [List<UserDataModel>] with more than 10 items',
          () async {
        //Arrange

        //Assert
        expect(usersList.length, greaterThan(10));
      });

      test(
          'should return a [UserDataModel] if item is contained inside the list',
          () async {
        //Arrange

        //Assert
        expect(usersList, contains(tModel));
      });
    },
  );

  group(
    'UserDataModel fromJson',
    () {
      test(
        'should return a [UserDataModel] with the right data',
        () async {
          //Arrange

          //Act
          final result = UserDataModel.fromJson(userJson);

          //Assert
          expect(result, tModel);
        },
      );
    },
  );

  group(
    'UserDataModel toMap',
    () {
      test(
        'should return [Map] with the right data using toMap',
        () async {
          //Arrange

          //Act
          final result = tModel.toMap();
          debugPrint(result.toString());

          //Assert
          expect(result, userMap);
        },
      );

      test(
        'should return [List<Map>] with the right data',
        () async {
          //Arrange

          //Act
          final result = usersList.map((e) => e.toMap()).toList();

          //Assert
          expect(result, userListMap);
        },
      );
    },
  );

  group(
    'UserDataModel toJson',
    () {
      test('should return [String] containing right data', () async {
        //Arrange

        //Act
        final result = tModel.toJson();
        debugPrint(result);
        debugPrint(userJson);

        //Assert
        expect(result, userJson);
      });
    },
  );
}
