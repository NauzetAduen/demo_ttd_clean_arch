import 'package:demo_tdd_clean_arch/core/error/failures.dart';
import 'package:demo_tdd_clean_arch/core/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

void main() {
  InputConverter converter;

  setUp(() {
    converter = InputConverter();
  });

  group('StringToUnsignedInt', () {
    test(
        'should return an integer when the string represents an unsigned integer',
        () async {
      //
      const str = '123';
      final result = converter.stringToUnsignedInteger(str);
      expect(result, Right(123));
    });
    test('should return Failure when str is not an integer', () async {
      const str = 'aaa';
      final result = converter.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFailure()));
    });
    test('should return Failure when str is a double', () async {
      const str = '3.0';
      final result = converter.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFailure()));
    });
    test('should return Failure when str is a negative number', () async {
      const str = '-1';
      final result = converter.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
