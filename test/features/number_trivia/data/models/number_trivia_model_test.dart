import 'dart:convert';

import 'package:demo_tdd_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:demo_tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test');
  test(
    'should be a subclass of NumberTrivia entity',
    () async {
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );

  group('fromJson', () {
    test('should return a valid model when the Json number is an integer',
        () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia.json')) as Map<String, dynamic>;

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });

    test('should return a valid model when the Json number is an double',
        () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json')) as Map<String, dynamic>;

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });
  });

  group('toJson', () {
    test('should return a json map', () {
      final result = tNumberTriviaModel.toJson();
      final expectedMap = {
        "text": "test",
        "number": 1,
      };

      expect(result, expectedMap);
    });
  });
}
