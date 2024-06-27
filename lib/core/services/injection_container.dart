import 'package:get_it/get_it.dart';
import 'package:tdd_clean_arch/src/authentication/data/data_source/authentication_remote_data_source.dart';
import 'package:tdd_clean_arch/src/authentication/data/data_source_impl/authentication_remote_data_source_impl.dart';
import 'package:tdd_clean_arch/src/authentication/data/repository_impl/authentication_repository_impl.dart';
import 'package:tdd_clean_arch/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_clean_arch/src/authentication/domain/use_cases.dart/create_user.dart';
import 'package:tdd_clean_arch/src/authentication/domain/use_cases.dart/get_users.dart';
import 'package:tdd_clean_arch/src/authentication/domain/use_cases.dart/update_user.dart';
import 'package:tdd_clean_arch/src/authentication/presentation/cubit/authentication_cubit.dart';

import 'package:http/http.dart' as http;

final sl = GetIt.instance;

/// Initializes the application by registering dependencies in the [sl] service locator.
///
/// This function registers the [AuthenticationCubit] with its dependencies,
/// and registers the [CreateUser], [GetUsers], and [UpdateUser] use cases.
/// It also registers the [AuthenticationRepository] and [AuthenticationRemoteDataSource]
/// with their dependencies. Finally, it registers an instance of [http.Client] for core functionality.
///
/// Returns a [Future<void>] that completes when all dependencies have been registered.
Future<void> init() async {
  sl.registerFactory(
    () => AuthenticationCubit(
      createUser: sl(),
      updateUser: sl(),
      getUsers: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => CreateUser(sl()));
  sl.registerLazySingleton(() => GetUsers(sl()));
  sl.registerLazySingleton(() => UpdateUser(sl()));

  // Repositories
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(sl()),
  );

  // Data Sources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(sl()),
  );

  // Core
  sl.registerLazySingleton(() => http.Client());
}
