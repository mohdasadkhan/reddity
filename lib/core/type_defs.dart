import 'package:fpdart/fpdart.dart';
import 'package:reddity/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
