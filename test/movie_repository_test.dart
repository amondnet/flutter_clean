import 'package:async/async.dart';
import 'package:clean/core/network_handler.dart';
import 'package:clean/features/movies/movie.dart';
import 'package:clean/features/movies/movie_entity.dart';
import 'package:clean/features/movies/movie_repository.dart';
import 'package:clean/features/movies/movies_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late NetworkHandler networkHandler;
  late MoviesService service;

  setUp(() {
    networkHandler = MockNetworkHandler();
    service = MockMoviesService();
  });

  test('success', () async {
    final repo = NetworkMoviesRepository(networkHandler, service);

    when(() => networkHandler.isNetworkAvailable).thenReturn(true);

    final stream = repo.moviesStream;
    final expectStream = expectLater(
        stream,
        emitsInOrder([
          [Movie(1, 'test')],
          [Movie(1, 'change')]
        ]));

    when(() => service.movies())
        .thenAnswer((_) async => [MovieEntity(1, 'test')]);
    final result1 = await repo.movies();
    expect(result1, isA<ValueResult>());

    when(() => service.movies())
        .thenAnswer((_) async => [MovieEntity(1, 'change')]);
    final result2 = await repo.movies();
    expect(result2, isA<ValueResult>());

    await expectStream;
  });
}

class MockNetworkHandler extends Mock implements NetworkHandler {}

class MockMoviesService extends Mock implements MoviesService {}
