import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /// Throws a [CacheException]
  Future<NumberTriviaModel> getLastNumberTrivia();

  /// Throws a [CacheException]
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}
