import '../../domain/datasources/movies_datasource.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;
  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated();
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming();
  }

  @override
  Future<Movie> getMovieById(String id) {
    return datasource.getMovieById(id);
  }
}
