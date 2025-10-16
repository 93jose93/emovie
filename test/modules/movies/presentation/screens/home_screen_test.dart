import 'package:emovie/modules/movies/data/datasources/movie_remote_datasource_provider.dart';
import 'package:emovie/modules/movies/presentation/screens/home_screen.dart';
import 'package:emovie/modules/movies/presentation/widgets/trending_section_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('HomeScreen muestra sección Trending',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => MovieRemoteDatasourceProvider(),
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    await tester.pumpAndSettle();

    // Verifica que el título principal esté presente
    expect(find.text('eMovie'), findsOneWidget);

    // Verifica que TrendingSectionWidget esté presente
    expect(find.byType(TrendingSectionWidget), findsOneWidget);

    // Verifica que el texto interno de la sección esté presente
    expect(find.textContaining('Tendencia'),
        findsWidgets); // ajusta si el texto es diferente
  });
}
