import 'package:dartz/dartz.dart';
import 'package:tdd_clean_arch/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultFutureVoid<T> = ResultFuture<void>;
