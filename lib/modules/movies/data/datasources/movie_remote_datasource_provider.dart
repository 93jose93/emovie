import 'package:emovie/core/network/api_base.dart';
import 'package:emovie/modules/movies/data/models/detail_movie_model.dart';
import 'package:emovie/modules/movies/data/models/recommendations_model.dart';
import 'package:emovie/modules/movies/data/models/trending_week_model.dart';
import 'package:emovie/modules/movies/data/models/upcoming_model.dart';
import 'package:flutter/foundation.dart';

class MovieRemoteDatasourceProvider extends ChangeNotifier {
  List<ResultUpcoming> upcomingMovies = [];
  List<ResultTrending> trendingMovies = [];
  List<ResultRecommended> recommendedMovies = [];
  List<ResultRecommended> filteredRecommendedMovies = [];

  DetailMovieModel? selectedMovieDetail;
  String? detailErrorMessage;
  String? trailerKey;

  String? errorMessage;
  bool isLoadingUpcoming = false;
  bool isLoadingTrending = false;
  bool isLoadingRecommended = false;
  bool isLoadingDetail = false;

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
        recommendedMovies = model.results; // ✅ guarda todos los resultados
        applyRecommendationFilters(); // ✅ aplica filtros (sin criterios al inicio)
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

  void applyRecommendationFilters({
    String? language,
    int? year,
  }) {
    filteredRecommendedMovies = recommendedMovies
        .where((movie) {
          final matchesLanguage =
              language == null || movie.originalLanguage == language;
          final matchesYear = year == null || movie.releaseDate?.year == year;
          return matchesLanguage && matchesYear;
        })
        .take(6) // ✅ limita después del filtro
        .toList();

    notifyListeners();
  }

  Future<void> getMovieDetail(int movieId) async {
    try {
      isLoadingDetail = true;
      notifyListeners();

      final json = await ApiBase.get('/movie/$movieId');
      selectedMovieDetail = DetailMovieModel.fromJson(json);
      detailErrorMessage = null;
    } catch (e) {
      detailErrorMessage = 'Error al cargar detalles de la película.';
      selectedMovieDetail = null;
    } finally {
      isLoadingDetail = false;
      notifyListeners();
    }
  }

  Future<void> getMovieTrailer(int movieId) async {
    try {
      final json = await ApiBase.get('/movie/$movieId/videos');
      final results = json['results'] as List<dynamic>;

      final trailer = results.firstWhere(
        (video) =>
            video['site'] == 'YouTube' &&
            video['type'] == 'Trailer' &&
            video['key'] != null,
        orElse: () => null,
      );

      trailerKey = trailer != null ? trailer['key'] as String : null;
    } catch (e) {
      trailerKey = null;
    }
  }
}
