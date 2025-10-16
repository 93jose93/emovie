part of 'routes_imports.dart';

@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: HomeScreenRoute.page,
          path: '/home',
          initial: true,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: MovieDetailScreenRoute.page,
          path: '/movie-detail/:movieId',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
      ];
}
