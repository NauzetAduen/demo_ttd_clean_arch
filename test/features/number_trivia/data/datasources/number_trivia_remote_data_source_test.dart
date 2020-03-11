import 'dart:convert';

import 'package:demo_tdd_clean_arch/core/error/exceptions.dart';
import 'package:demo_tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:demo_tdd_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;
import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  //
  NumberTriviaRemoteDataSourceImpl dataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
        json.decode(fixture('trivia.json')) as Map<String, dynamic>);
    test('''should perform a get request on a URL with number
     being the endpoint with the correct header application/json''', () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));

      dataSourceImpl.getConcreteNumberTrivia(tNumber);

      verify(mockHttpClient.get(
        'http://numbersapi.com/$tNumber',
        headers: {'Content-Type': 'application/json'},
      ));
    });
    test('should return NumberTrivia when responsecode is 200', () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
      final result = await dataSourceImpl.getConcreteNumberTrivia(tNumber);

      expect(result, tNumberTriviaModel);
    });
    test('should throw a ServerException when statuscode != 200', () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Error', 404));

      final call = dataSourceImpl.getConcreteNumberTrivia;
      expect(
          () => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });
  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
        json.decode(fixture('trivia.json')) as Map<String, dynamic>);
    test('''should perform a get request on a URL with number
     being the endpoint with the correct header application/json''', () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));

      dataSourceImpl.getRandomNumberTrivia();

      verify(mockHttpClient.get(
        'http://numbersapi.com/random',
        headers: {'Content-Type': 'application/json'},
      ));
    });
    test('should return NumberTrivia when responsecode is 200', () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
      final result = await dataSourceImpl.getRandomNumberTrivia();

      expect(result, tNumberTriviaModel);
    });
    test('should throw a ServerException when statuscode != 200', () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Error', 404));

      final call = dataSourceImpl.getRandomNumberTrivia;
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
