import 'package:dartz/dartz.dart';
import 'package:demo_tdd_clean_arch/core/error/exceptions.dart';
import 'package:demo_tdd_clean_arch/core/error/failures.dart';
import 'package:demo_tdd_clean_arch/core/platform/network_info.dart';
import 'package:demo_tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:demo_tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:demo_tdd_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:demo_tdd_clean_arch/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:demo_tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl repositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) => Future.value(true));
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((_) => Future.value(false));
      });
      body();
    });
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel(number: tNumber, text: 'test');
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;

    test('should check if there is internet conection', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) => Future.value(true));

      repositoryImpl.getConcreteNumberTrivia(tNumber);

      verify(mockNetworkInfo.isConnected);

      verifyNoMoreInteractions(mockNetworkInfo);
    });

    runTestOnline(() {
      test('should return remote data when calling remoteDataSource', () async {
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);

        expect(result, equals(Right(tNumberTrivia)));
      });
      test('should cache the data locally when calling remoteDataSource',
          () async {
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);
        await repositoryImpl.getConcreteNumberTrivia(tNumber);

        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });
      test('should return ServerFailure when call is unsuccesful', () async {
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());
        final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);

        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
    runTestOffline(() {
      test('should return last locally cached data when data is present',
          () async {
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, Right(tNumberTrivia));
      });
      test('should return CacheFailure when there is no localData', () async {
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());

        final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());

        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
