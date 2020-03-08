import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

/// returned after caching a [ServerException]
///
/// Used by useCases

class ServerFailure extends Failure {}

/// returned after caching a [CacheException]
///
/// Used by useCases

class CacheFailure extends Failure {}
