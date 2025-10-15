part of 'routes_imports.dart';

@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // Ejemplo de rutas (puedes activar cuando tengas las vistas)
        // CustomRoute(
        //   page: SplashViewRoute.page,
        //   path: '/',
        //   initial: true,
        //   transitionsBuilder: TransitionsBuilders.fadeIn,
        // ),
        CustomRoute(
          page: HomeScreenRoute.page,
          path: '/home',
          initial: true,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        // CustomRoute(
        //   page: MovieDetailViewRoute.page,
        //   path: '/movie/:id',
        //   transitionsBuilder: TransitionsBuilders.slideLeft,
        // ),
      ];
}
