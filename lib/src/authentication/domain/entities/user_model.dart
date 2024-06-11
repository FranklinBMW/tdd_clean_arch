// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String createdAt;
  final String avatar;

  const UserModel.emptyUser()
      : this(
          id: '0',
          name: '',
          avatar: '',
          createdAt: '',
        );

  @override
  List<Object?> get props => [id];
}
