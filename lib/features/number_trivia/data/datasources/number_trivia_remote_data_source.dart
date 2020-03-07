import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// http://numbersapi.com/{number}?json
  /// Throws [ServerException]
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  ///http://numbersapi.com/random
  ///Throws [ServerException]
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
