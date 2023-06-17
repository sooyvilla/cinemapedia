import '../../domain/entities/actor.dart';
import '../model/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://www.trentanddove.org/media/4566/greyed-out-profile.png?anchor=center&mode=crop&width=290&height=340&format=jpeg&bgcolor=FFFFFF&quality=75&rnd=132920834630000000',
      character: cast.character);
}
