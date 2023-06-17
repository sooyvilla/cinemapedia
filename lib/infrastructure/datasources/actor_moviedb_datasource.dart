import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';
import '../../domain/datasources/actors_datasource.dart';
import '../../domain/entities/actor.dart';
import '../mappers/actor_mapper.dart';
import '../model/moviedb/credits_response.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'lenguage': 'es-MX'
    },
  ));

  @override
  Future<List<Actor>> getActorByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    final castResponse = CreditsResponse.fromMap(response.data);

    return castResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();
  }
}
