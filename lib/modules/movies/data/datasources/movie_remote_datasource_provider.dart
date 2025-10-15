import 'package:emovie/core/network/api_base.dart';
import 'package:emovie/modules/movies/data/models/recommendations_model.dart';
import 'package:emovie/modules/movies/data/models/trending_week_model.dart';
import 'package:emovie/modules/movies/data/models/upcoming_model.dart';
import 'package:flutter/foundation.dart';

class MovieRemoteDatasourceProvider extends ChangeNotifier {
  List<ResultUpcoming> upcomingMovies = [];
  List<ResultTrending> trendingMovies = [];
  List<ResultRecommended> recommendedMovies = [];

  String? errorMessage;
  bool isLoadingUpcoming = false;
  bool isLoadingTrending = false;
  bool isLoadingRecommended = false;

  MovieRemoteDatasourceProvider();

  Future<void> getUpcomingMovies() async {
    try {
      isLoadingUpcoming = true;
      notifyListeners();

      final json = await ApiBase.get('/movie/upcoming');

      final upcomingModel = UpcomingModel.fromJson(json);

      if (upcomingModel.results.isNotEmpty) {
        upcomingMovies = upcomingModel.results;
        errorMessage = null;
      } else {
        errorMessage = 'No se encontraron películas próximas.';
      }
    } catch (e) {
      errorMessage = 'Error al obtener películas próximas.';
    } finally {
      isLoadingUpcoming = false;
      notifyListeners();
    }
  }

  Future<void> getTrendingMovies() async {
    try {
      isLoadingTrending = true;
      notifyListeners();

      final json = await ApiBase.get('/trending/movie/week');
      //print("📦 JSON recibido: $json");

      final trendingModel = TrendingWeekModel.fromJson(json);

      if (trendingModel.results.isNotEmpty) {
        trendingMovies = trendingModel.results;
        errorMessage = null;
      } else {
        errorMessage = 'No se encontraron películas en tendencia.';
      }
    } catch (e) {
      errorMessage = 'Error al obtener películas en tendencia.';
    } finally {
      isLoadingTrending = false;
      notifyListeners();
    }
  }

  Future<void> getRecommendedMovies({int movieId = 550}) async {
    try {
      isLoadingRecommended = true;
      notifyListeners();

      final json = await ApiBase.get('/movie/$movieId/recommendations');
      final model = RecommendationsModel.fromJson(json);

      if (model.results.isNotEmpty) {
        recommendedMovies = model.results.take(6).toList(); // solo 6
        errorMessage = null;
      } else {
        errorMessage = 'No se encontraron recomendaciones.';
      }
    } catch (e) {
      errorMessage = 'Error al obtener recomendaciones.';
    } finally {
      isLoadingRecommended = false;
      notifyListeners();
    }
  }
}
