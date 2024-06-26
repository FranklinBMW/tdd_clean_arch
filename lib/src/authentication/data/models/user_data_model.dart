// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tdd_clean_arch/core/utils/typedef.dart';
import 'package:tdd_clean_arch/src/authentication/domain/entities/user_model.dart';

class UserDataModel extends UserModel {
  const UserDataModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.avatar,
  });

  UserDataModel copyWith({
    String? id,
    String? name,
    String? createdAt,
    String? avatar,
  }) {
    return UserDataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  DataMap toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'avatar': avatar,
      'createdAt': createdAt,
    };
  }

  @override
  String toJson() => json.encode(toMap());

  factory UserDataModel.fromMap(DataMap map) {
    return UserDataModel(
      id: map['id'] as String,
      name: map['name'] as String,
      avatar: map['avatar'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  factory UserDataModel.fromJson(String source) =>
      UserDataModel.fromMap(json.decode(source) as DataMap);

  const UserDataModel.emptyUser()
      : this(
          id: '4',
          name: 'Alice Nader',
          avatar:
              'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/710.jpg',
          createdAt: '2024-06-07T04:11:58.618Z',
        );

  @override
  String toString() {
    return 'UserDataModel(id: $id, name: $name, createdAt: $createdAt, avatar: $avatar)';
  }
}
