part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

final class AuthenticationCreatingUser extends AuthenticationState {
  const AuthenticationCreatingUser();
}

final class AuthenticationCreatedUser extends AuthenticationState {
  const AuthenticationCreatedUser();
}

final class AuthenticationUpdatingUser extends AuthenticationState {
  const AuthenticationUpdatingUser();
}

final class AuthenticationUpdatedUser extends AuthenticationState {
  const AuthenticationUpdatedUser();
}

final class AuthenticationGettingUsers extends AuthenticationState {
  const AuthenticationGettingUsers();
}

final class AuthenticationGetUsers extends AuthenticationState {
  const AuthenticationGetUsers({required this.users});

  final List<UserModel> users;

  @override
  List<Object> get props => users.map((e) => e.id).toList();
}

final class AuthenticationError extends AuthenticationState {
  const AuthenticationError({required this.errorMessage});

  final String errorMessage;

  @override
  List<String> get props => [errorMessage];
}
