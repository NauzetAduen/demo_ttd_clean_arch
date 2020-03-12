import 'package:demo_tdd_clean_arch/core/util/input_converter.dart';
import 'package:demo_tdd_clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:demo_tdd_clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:demo_tdd_clean_arch/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  //
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      mockGetConcreteNumberTrivia,
      mockGetRandomNumberTrivia,
      mockInputConverter,
    );
  });

  test('initialState should be Empty', () async {
    expect(bloc.initialState, equals(Empty()));
  });
}
