import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';
import '../../presentation/views/views.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const HomeView();
          },
          routes: [
            GoRoute(
              path: 'movie/:id',
              name: MoviesScreen.name,
              builder: (context, state) {
                final movieId = state.pathParameters['id'] ?? 'no-id';
                return MoviesScreen(movieId: movieId);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            return const FavoritesView();
          },
        ),
      ],
    ),

    //rutas padre/hijo
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) => const HomeScreen(
    //     childView: FavoritesView(),
    //   ),
    //   routes: [
    //     GoRoute(
    //       path: 'movie/:id',
    //       name: MoviesScreen.name,
    //       builder: (context, state) {
    //         final movieId = state.pathParameters['id'] ?? 'no-id';
    //         return MoviesScreen(movieId: movieId);
    //       },
    //     ),
    //   ],
    // ),
  ],
);
