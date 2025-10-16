import 'package:auto_route/auto_route.dart';
import 'package:emovie/modules/movies/data/datasources/movie_remote_datasource_provider.dart';
import 'package:emovie/modules/movies/data/models/upcoming_model.dart';
import 'package:emovie/routes/routes_imports.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpcomingSectionWidget extends StatelessWidget {
  const UpcomingSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieRemoteDatasourceProvider>();
    final movies = provider.upcomingMovies;

    const titleColor = Colors.white;
    const subtitleColor = Colors.white70;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Próximos estrenos',
          style: TextStyle(
            color: titleColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: provider.isLoadingUpcoming
              ? const Center(child: CircularProgressIndicator())
              : movies.isEmpty
                  ? const Center(child: Text('No hay estrenos disponibles'))
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final ResultUpcoming movie = movies[index];
                        final posterUrl = movie.posterPath != null
                            ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                            : null;

                        return InkWell(
                          onTap: () {
                            context.pushRoute(
                              MovieDetailScreenRoute(movieId: movie.id!),
                            );
                          },
                          child: Container(
                            width: 120,
                            margin: const EdgeInsets.only(right: 12),
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
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }
}
