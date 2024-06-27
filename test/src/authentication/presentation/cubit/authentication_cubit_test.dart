import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_arch/core/errors/failure.dart';
import 'package:tdd_clean_arch/src/authentication/domain/entities/user_model.dart';
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

  const tCreateUserParams = CreateUserParams.emptyParams();
  final tUpdateUserParams = UpdateUserParams.empty();
  const tApiFailure = ApiFailure(message: 'error', statusCode: 400);
  const tUsersModel = [
    UserModel(
      id: '1',
      name: 'name',
      createdAt: 'createdAt',
      avatar: 'avatar',
    ),
    UserModel(
      id: '2',
      name: 'name',
      createdAt: 'createdAt',
      avatar: 'avatar',
    ),
    UserModel(
      id: '3',
      name: 'name',
      createdAt: 'createdAt',
      avatar: 'avatar',
    ),
  ];

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
      registerFallbackValue(tCreateUserParams);
      registerFallbackValue(tUpdateUserParams);
    },
  );

  test(
    'initial state should be [AuthenticationInitial]',
    () async =>
        expect(authenticationCubit.state, const AuthenticationInitial()),
  );

  group(
    'CreateUser',
    () {
      blocTest(
        'should emit [AuthenticationCreatingUser, AuthenticationCreatedUser] when successful',
        build: () {
          when(
            () => mockCreateUsers(any()),
          ).thenAnswer(
            (_) async => const Right(null),
          );

          return authenticationCubit;
        },
        act: (cubit) {
          cubit.createUser(
            name: tCreateUserParams.name,
            createdAt: tCreateUserParams.createdAt,
            avatar: tCreateUserParams.avatar,
          );
        },
        expect: () => const [
          AuthenticationCreatingUser(),
          AuthenticationCreatedUser(),
        ],
        verify: (_) {
          verify(
            () => mockCreateUsers(tCreateUserParams),
          ).called(1);
          verifyNoMoreInteractions(mockCreateUsers);
        },
      );

      blocTest(
        'should emit [AuthenticationCreatingUser, AuthenticationError] when failed create user',
        build: () {
          when(() => mockCreateUsers(any())).thenAnswer(
            (_) async => const Left(tApiFailure),
          );
          return authenticationCubit;
        },
        act: (cubit) {
          cubit.createUser(
            name: tCreateUserParams.name,
            createdAt: tCreateUserParams.createdAt,
            avatar: tCreateUserParams.avatar,
          );
        },
        expect: () => [
          const AuthenticationCreatingUser(),
          AuthenticationError(
              errorMessage:
                  '${tApiFailure.statusCode} - ${tApiFailure.message}'),
        ],
        verify: (_) {
          verify(
            () => mockCreateUsers(tCreateUserParams),
          ).called(1);
          verifyNoMoreInteractions(mockCreateUsers);
        },
      );
    },
  );
  group(
    'UpdateUser',
    () {
      blocTest(
        'should emit [AuthenticationUpdatingUser, AuthenticationUpdatedUser]',
        build: () {
          when(
            () => mockUpdateUsers(any()),
          ).thenAnswer((_) async {
            return const Right(null);
          });

          return authenticationCubit;
        },
        act: (cubit) => cubit.updateUser(
          id: tUpdateUserParams.id,
          name: tUpdateUserParams.userName,
          avatar: tUpdateUserParams.avatar,
        ),
        expect: () => const [
          AuthenticationUpdatingUser(),
          AuthenticationUpdatedUser(),
        ],
        verify: (_) {
          verify(
            () => mockUpdateUsers(tUpdateUserParams),
          ).called(1);
          verifyNoMoreInteractions(mockUpdateUsers);
        },
      );

      blocTest(
        'should emit [AuthenticationUpdatingUser, AuthenticationError]',
        build: () {
          when(() => mockUpdateUsers(any())).thenAnswer((_) async {
            return const Left(tApiFailure);
          });
          return authenticationCubit;
        },
        act: (cubit) => cubit.updateUser(
          id: tUpdateUserParams.id,
          name: tUpdateUserParams.userName,
          avatar: tUpdateUserParams.avatar,
        ),
        expect: () => [
          const AuthenticationUpdatingUser(),
          AuthenticationError(
              errorMessage:
                  '${tApiFailure.statusCode} - ${tApiFailure.message}'),
        ],
        verify: (_) {
          verify(() => mockUpdateUsers(tUpdateUserParams)).called(1);
          verifyNoMoreInteractions(mockUpdateUsers);
        },
      );
    },
  );
  group(
    'GetUsers',
    () {
      blocTest(
        'should emit [AuthenticationGettingUsers, AuthenticationGetUsers] when successful',
        build: () {
          when(() => mockGetUsers()).thenAnswer(
            (_) async => const Right(tUsersModel),
          );
          return authenticationCubit;
        },
        act: (cubit) => cubit.getUsers(),
        expect: () => const [
          AuthenticationGettingUsers(),
          AuthenticationGetUsers(users: tUsersModel),
        ],
        verify: (_) {
          verify(() => mockGetUsers()).called(1);
          verifyNoMoreInteractions(mockGetUsers);
        },
      );

      blocTest(
        'should emit [AuthenticationGettingUsers, AuthenticationGetUsers] when list size is 0',
        build: () {
          when(() => mockGetUsers()).thenAnswer(
            (_) async => const Right([]),
          );
          return authenticationCubit;
        },
        act: (cubit) => cubit.getUsers(),
        expect: () => const [
          AuthenticationGettingUsers(),
          AuthenticationGetUsers(users: []),
        ],
        verify: (_) {
          verify(() => mockGetUsers()).called(1);
          verifyNoMoreInteractions(mockGetUsers);
        },
      );

      blocTest(
        'should emit [AuthenticationGettingUsers, AuthenticationError] when failed',
        build: () {
          when(() => mockGetUsers()).thenAnswer(
            (_) async => const Left(tApiFailure),
          );
          return authenticationCubit;
        },
        act: (cubit) => cubit.getUsers(),
        expect: () => [
          const AuthenticationGettingUsers(),
          AuthenticationError(
              errorMessage:
                  '${tApiFailure.statusCode} - ${tApiFailure.message}'),
        ],
        verify: (_) {
          verify(() => mockGetUsers()).called(1);
          verifyNoMoreInteractions(mockGetUsers);
        },
      );
    },
  );

  tearDown(
    () => authenticationCubit.close(),
  );
}
