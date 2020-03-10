import 'dart:convert';

import 'package:demo_tdd_clean_arch/core/error/exceptions.dart';
import 'package:demo_tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:demo_tdd_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDataSourceImpl dataSourceImpl;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = NumberTriviaLocalDataSourceImpl(mockSharedPreferences);
  });

  group("getLastNumberTrivia", () {
    final fixtureString = fixture('trivia_cached.json');
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
        json.decode(fixtureString) as Map<String, dynamic>);
    test(
        'should return NumberTrivia from SharedPreferences when there is one cached',
        () async {
      when(mockSharedPreferences.getString(any)).thenReturn(fixtureString);

      final result = await dataSourceImpl.getLastNumberTrivia();

      verify(mockSharedPreferences.getString(cachedNumberTrivia));
      expect(result, tNumberTriviaModel);
    });
    test('should throw CacheException when there is no cachedTrivia', () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final call = dataSourceImpl.getLastNumberTrivia;

      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel(number: 1, text: "test");
    test('should call sharedPreferences to cache the data', () async {
      //
      dataSourceImpl.cacheNumberTrivia(tNumberTriviaModel);
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(mockSharedPreferences.setString(
          cachedNumberTrivia, expectedJsonString));
    });
  });
}
