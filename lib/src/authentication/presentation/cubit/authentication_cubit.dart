import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_clean_arch/src/authentication/domain/entities/user_model.dart';
import 'package:tdd_clean_arch/src/authentication/domain/use_cases.dart/create_user.dart';
import 'package:tdd_clean_arch/src/authentication/domain/use_cases.dart/get_users.dart';
import 'package:tdd_clean_arch/src/authentication/domain/use_cases.dart/update_user.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required CreateUser createUser,
    required UpdateUser updateUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _updateUser = updateUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial());

  final CreateUser _createUser;
  final UpdateUser _updateUser;
  final GetUsers _getUsers;

  /// Asynchronously creates a user.
  ///
  /// This function takes in the required parameters [name], [createdAt], and [avatar] of type `String`.
  /// It emits an [AuthenticationCreatingUser] state to indicate that the user creation process has started.
  /// Then, it calls the [_createUser] function with the provided [CreateUserParams] to create a new user.
  /// If the user creation is successful, it emits an [AuthenticationCreatedUser] state.
  /// If there is an error during the user creation process, it emits an [AuthenticationError] state with the error message.
  /// If an exception occurs during the user creation process, it emits an [AuthenticationError] state with the exception message.
  ///
  /// Parameters:
  /// - `name` (required): The name of the user.
  /// - `createdAt` (required): The creation date of the user.
  /// - `avatar` (required): The avatar of the user.
  ///
  /// Returns a [Future<void>] that completes when the user creation process is complete.
  Future<void> createUser({
    required String name,
    required String createdAt,
    required String avatar,
  }) async {
    emit(const AuthenticationCreatingUser());
    try {
      final result = await _createUser(
        CreateUserParams(
          name: name,
          avatar: avatar,
          createdAt: createdAt,
        ),
      );

      result.fold(
        (failure) => emit(
          AuthenticationError(
              errorMessage: '${failure.statusCode} - ${failure.message}'),
        ),
        (_) => emit(const AuthenticationCreatedUser()),
      );
    } catch (e) {
      emit(AuthenticationError(errorMessage: e.toString()));
    }
  }

  /// Asynchronously handles the update of a user event.
  /// @return {Future<void>} - A Future that completes when the user update process is complete.
  Future<void> updateUserEvent({
    required String id,
    required String name,
    required String avatar,
  }) async {
    emit(const AuthenticationUpdatingUser());

    try {
      final result = await _updateUser(
        UpdateUserParams(
          id: id,
          userName: name,
          avatar: avatar,
        ),
      );

      result.fold(
        (failure) => emit(
          AuthenticationError(
            errorMessage: '${failure.statusCode} - ${failure.message}',
          ),
        ),
        (_) => emit(
          const AuthenticationUpdatedUser(),
        ),
      );
    } catch (e) {
      emit(
        AuthenticationError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Asynchronously handles the retrieval of users event.
  ///
  /// This function takes in a [GetUsersEvent] and an [Emitter] as parameters.
  /// It first emits an [AuthenticationGettingUsers] state to indicate that the user retrieval process has started.
  /// Then, it calls the [_getUsers] function to retrieve a list of users.
  /// If the user retrieval is successful, it emits an [AuthenticationGetUsers] state with the retrieved users.
  /// If there is an error during the user retrieval process, it emits an [AuthenticationError] state with the error message.
  /// If an exception occurs during the user retrieval process, it emits an [AuthenticationError] state with the exception message.
  /// Returns a [Future<void>] that completes when the user retrieval process is complete.
  Future<void> getUsersEvent() async {
    emit(const AuthenticationGettingUsers());
    try {
      final result = await _getUsers();
      result.fold(
        (failure) => emit(
          AuthenticationError(
            errorMessage: '${failure.statusCode} - ${failure.message}',
          ),
        ),
        (users) => emit(
          AuthenticationGetUsers(users: users),
        ),
      );
    } catch (e) {
      emit(
        AuthenticationError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
