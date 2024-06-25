import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_arch/src/authentication/domain/use_cases.dart/create_user.dart';
import 'package:tdd_clean_arch/src/authentication/domain/use_cases.dart/get_users.dart';
import 'package:tdd_clean_arch/src/authentication/domain/use_cases.dart/update_user.dart';
import 'package:tdd_clean_arch/src/authentication/presentation/cubit/authentication_cubit.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockUpdateUsers extends Mock implements UpdateUser {}

class MockCreateUsers extends Mock implements CreateUser {}

void main() {
  late AuthenticationCubit authenticationCubit;
  late GetUsers mockGetUsers;
  late UpdateUser mockUpdateUsers;
  late CreateUser mockCreateUsers;

  setUp(
    () {
      mockGetUsers = MockGetUsers();
      mockUpdateUsers = MockUpdateUsers();
      mockCreateUsers = MockCreateUsers();
      authenticationCubit = AuthenticationCubit(
        getUsers: mockGetUsers,
        updateUser: mockUpdateUsers,
        createUser: mockCreateUsers,
      );
    },
  );

  test(
    'initial state should be [AuthenticationInitial]',
    () async =>
        expect(authenticationCubit.state, const AuthenticationInitial()),
  );

  group(
    'CreateUser',
    () {},
  );
  group(
    'UpdateUser',
    () {},
  );
  group(
    'GetUsers',
    () {},
  );

  tearDown(
    () => authenticationCubit.close(),
  );
}
