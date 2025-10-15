import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:emovie/core/network/api_base.dart';
import 'package:emovie/core/storage/local_storage.dart';
import 'package:emovie/core/theme/splash_content.dart';
import 'package:emovie/modules/movies/data/datasources/movie_remote_datasource_provider.dart';
import 'package:emovie/routes/routes_imports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

late final AppRouter appRouter;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Configuración inicial
  if (kIsWeb) {
    usePathUrlStrategy(); // rutas limpias sin #
  }

  // Inicializaciones globales
  await LocalStorage.configurePrefs();
  ApiBase.configureDio();

  // 🔹 Router con dependencias
  appRouter = AppRouter();

  runApp(
    MultiProvider(
      providers: [
        // Provider<int>.value(value: 0),
        ChangeNotifierProvider(
          create: (_) => MovieRemoteDatasourceProvider()
            ..getUpcomingMovies()
            ..getTrendingMovies()
            ..getRecommendedMovies(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eMovie',
      home: AnimatedSplashScreen(
        splashIconSize: double.infinity,
        splash: const SplashContent(),
        nextScreen: const AppRouterWrapper(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        duration: 2500,
      ),
    );
  }
}

/// Este widget envuelve tu router para usar con AnimatedSplashScreen
class AppRouterWrapper extends StatelessWidget {
  const AppRouterWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TMDb Flutter App',
      routerConfig: appRouter.config(),
    );
  }
}
