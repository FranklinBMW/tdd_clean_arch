import 'package:dartz/dartz.dart';
import 'package:tdd_clean_arch/core/errors/exceptions.dart';
import 'package:tdd_clean_arch/core/errors/failure.dart';
import 'package:tdd_clean_arch/core/utils/typedef.dart';
import 'package:tdd_clean_arch/src/authentication/data/data_source/authentication_remote_data_source.dart';
import 'package:tdd_clean_arch/src/authentication/domain/entities/user_model.dart';
import 'package:tdd_clean_arch/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(this._dataSource);
  final AuthenticationRemoteDataSource _dataSource;
  @override
  ResultFutureVoid createUser(
      {required String name,
      required String createdAt,
      required String avatar}) async {
    /* 
      Test-Driven Development
      - Check RemoteDataSource
      - Check if the method returns proper data
      - Check if the method returns proper error
      - Make sure that the method returns proper data if there is no error
      - Make sure that the method returns proper error if there is an error
     */
    try {
      await _dataSource.createUser(
          name: name, avatar: avatar, createdAt: createdAt);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(
        ApiFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<List<UserModel>> getUsers() async {
    try {
      final usersResponse = await _dataSource.getUsers();
      return Right(usersResponse);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFutureVoid updateUser(
      {required String name, required String avatar}) async {
    try {
      await _dataSource.updateUser(name: name, avatar: avatar);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
