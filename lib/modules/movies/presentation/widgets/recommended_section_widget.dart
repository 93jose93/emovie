import 'package:emovie/core/theme/widgets/filter_toggle_button.dart';
import 'package:emovie/modules/movies/data/datasources/movie_remote_datasource_provider.dart';
import 'package:emovie/modules/movies/data/models/recommendations_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecommendedSectionWidget extends StatefulWidget {
  const RecommendedSectionWidget({super.key});

  @override
  State<RecommendedSectionWidget> createState() =>
      _RecommendedSectionWidgetState();
}

class _RecommendedSectionWidgetState extends State<RecommendedSectionWidget> {
  bool isSpanishSelected = false;
  bool isYear1993Selected = false;

  void toggleSpanish() {
    setState(() {
      isSpanishSelected = !isSpanishSelected;
    });
  }

  void toggleYear1993() {
    setState(() {
      isYear1993Selected = !isYear1993Selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieRemoteDatasourceProvider>();
    final movies = provider.recommendedMovies;

    const titleColor = Colors.white;
    const subtitleColor = Colors.white70;

    return Column(
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
              label: 'En español',
              selected: isSpanishSelected,
              onTap: toggleSpanish,
            ),
            const SizedBox(width: 12),
            FilterToggleButton(
              label: 'Lanzadas en 1993',
              selected: isYear1993Selected,
              onTap: toggleYear1993,
            ),
          ],
        ),
        const SizedBox(height: 16),
        provider.isLoadingRecommended
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: posterUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              posterUrl,
                              fit: BoxFit.cover,
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
                  );
                },
              ),
      ],
    );
  }
}
