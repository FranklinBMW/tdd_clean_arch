part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AuthenticationEvent {
  const CreateUserEvent({
    required this.avatar,
    required this.name,
    required this.createdAt,
  });
  final String avatar;
  final String name;
  final String createdAt;

  @override
  List<Object> get props => [avatar, name, createdAt];
}

class UpdateUserEvent extends AuthenticationEvent {
  const UpdateUserEvent({
    required this.avatar,
    required this.name,
    required this.id,
  });
  final String avatar;
  final String name;
  final String id;

  @override
  List<Object> get props => [avatar, name, id];
}

class GetUsersEvent extends AuthenticationEvent {
  const GetUsersEvent();
}
