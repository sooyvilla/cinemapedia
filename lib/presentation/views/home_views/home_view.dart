import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initalLoading = ref.watch(initialLoadingProvider);

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return Stack(
      children: [
        Visibility(
          visible: !initalLoading,
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: CustomAppbar(),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Column(
                    children: [
                      // const CustomAppbar(),
                      MoviesSlideshow(movies: slideShowMovies),
                      CardsHorizontalListView(
                        movies: nowPlayingMovies,
                        title: 'En cines',
                        subTitle: 'Lunes 20',
                        loadNextPage: () => ref
                            .read(nowPlayingMoviesProvider.notifier)
                            .loadNextPage(),
                      ),
                      CardsHorizontalListView(
                        movies: upcomingMovies,
                        title: 'Proximamente',
                        subTitle: 'En este mes',
                        loadNextPage: () => ref
                            .read(upcomingMoviesProvider.notifier)
                            .loadNextPage(),
                      ),
                      CardsHorizontalListView(
                        movies: popularMovies,
                        title: 'Populares',
                        // subTitle: '',
                        loadNextPage: () => ref
                            .read(popularMoviesProvider.notifier)
                            .loadNextPage(),
                      ),
                      CardsHorizontalListView(
                        movies: topRatedMovies,
                        title: 'Mejor calificados',
                        subTitle: 'Desde siempre',
                        loadNextPage: () => ref
                            .read(topRatedMoviesProvider.notifier)
                            .loadNextPage(),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  );
                }, childCount: 1),
              )
            ],
          ),
        ),
        if (initalLoading) const FullScreenLoader(),
      ],
    );
  }
}
