import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import 'movies_repository_provider.dart';

final movieRecomendationProvider =
    StateNotifierProvider<MovieRecomendation, List<Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider).getRecomendation;
  return MovieRecomendation(fetchMoreMovies: movieRepository);
});

typedef GetMovieCallBack = Future<List<Movie>> Function(String movieId,
    {int page});

class MovieRecomendation extends StateNotifier<List<Movie>> {
  bool isLoading = false;
  int currentPage = 0;
  final GetMovieCallBack fetchMoreMovies;
  MovieRecomendation({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage(String movieId) async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;
    final List<Movie> movies =
        await fetchMoreMovies(movieId, page: currentPage);
    state = [...state, ...movies];
    isLoading = false;
  }
}
