import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/src/authentication/data/models/user_data_model.dart';
import 'package:tdd_clean_arch/src/authentication/domain/entities/user_model.dart';

void main() {
  test('should be a subClass of [UserModel] entity', () async {
    // Arrange
    const tModel = UserDataModel.emptyUser();
    // Act

    // Assert
    expect(tModel, isA<UserModel>());
  });
  group(
    'user data model from map',
    () {
      test(
        '',
        () async {},
      );
    },
  );
}
