import 'dart:convert';

import 'package:demo_tdd_clean_arch/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /// Throws a [CacheException]
  Future<NumberTriviaModel> getLastNumberTrivia();

  /// Throws a [CacheException]
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const String cachedNumberTrivia = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(
        cachedNumberTrivia,
        json.encode(
          triviaToCache.toJson(),
        ));
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(cachedNumberTrivia);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(
          json.decode(jsonString) as Map<String, dynamic>));
    } else {
      throw CacheException();
    }
  }
}
