import 'package:auto_route/auto_route.dart';
import 'package:emovie/core/theme/widgets/filter_toggle_button.dart';
import 'package:emovie/modules/movies/data/datasources/movie_remote_datasource_provider.dart';
import 'package:emovie/modules/movies/data/models/recommendations_model.dart';
import 'package:emovie/routes/routes_imports.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecommendedSectionWidget extends StatefulWidget {
  const RecommendedSectionWidget({super.key});

  @override
  State<RecommendedSectionWidget> createState() =>
      _RecommendedSectionWidgetState();
}

class _RecommendedSectionWidgetState extends State<RecommendedSectionWidget> {
  bool isPortugueseSelected = false;
  bool isYearSelected = false;

  void togglePortuguese() {
    setState(() {
      isPortugueseSelected = !isPortugueseSelected;
    });
    applyFilters();
  }

  void toggleYear() {
    setState(() {
      isYearSelected = !isYearSelected;
    });
    applyFilters();
  }

  void applyFilters() {
    final provider = context.read<MovieRemoteDatasourceProvider>();
    provider.applyRecommendationFilters(
      language: isPortugueseSelected ? 'pt' : null,
      year: isYearSelected ? 2012 : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieRemoteDatasourceProvider>();
    final movies = provider.filteredRecommendedMovies;

    const titleColor = Colors.white;
    const subtitleColor = Colors.white70;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recomendados para ti',
            style: TextStyle(
              color: titleColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              FilterToggleButton(
                label: 'En portugués',
                selected: isPortugueseSelected,
                onTap: togglePortuguese,
              ),
              const SizedBox(width: 12),
              FilterToggleButton(
                label: 'Lanzadas en 2012',
                selected: isYearSelected,
                onTap: toggleYear,
              ),
            ],
          ),
          const SizedBox(height: 16),
          provider.isLoadingRecommended
              ? const Center(child: CircularProgressIndicator())
              : movies.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: Center(
                        child: Text(
                          'No hay coincidencias con los filtros',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final ResultRecommended movie = movies[index];
                        final posterUrl = movie.posterPath != null
                            ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                            : null;

                        return InkWell(
                          onTap: () {
                            final id = movie.id;
                            if (id != null) {
                              context.pushRoute(
                                  MovieDetailScreenRoute(movieId: id));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Esta película no tiene ID')),
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: posterUrl != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: FadeInImage.assetNetwork(
                                      placeholder:
                                          'assets/images/movie/placeholder.png',
                                      image: posterUrl,
                                      fit: BoxFit.cover,
                                      fadeInDuration:
                                          const Duration(milliseconds: 300),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      movie.title ?? 'Sin título',
                                      style: const TextStyle(
                                        color: subtitleColor,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
        ],
      ),
    );
  }
}
