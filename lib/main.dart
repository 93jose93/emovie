import 'package:emovie/core/network/api_base.dart';
import 'package:emovie/core/storage/local_storage.dart';
import 'package:emovie/routes/routes_imports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
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

  // 🔹 Instancias base
  // final moviesRemoteDatasource = MoviesRemoteDatasource();
  // final moviesProvider = MoviesProvider(moviesRemoteDatasource);

  // 🔹 Router con dependencias
  appRouter = AppRouter();

  runApp(
    MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => moviesProvider),
        Provider<int>.value(value: 0),
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TMDb Flutter App',
      routerConfig: appRouter.config(),
    );
  }
}
