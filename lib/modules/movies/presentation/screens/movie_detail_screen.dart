import 'package:auto_route/auto_route.dart';
import 'package:emovie/modules/movies/data/datasources/movie_remote_datasource_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@RoutePage()
class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final provider = context.read<MovieRemoteDatasourceProvider>();
      provider.getMovieDetail(widget.movieId);
      provider.getMovieTrailer(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieRemoteDatasourceProvider>();
    final movie = provider.selectedMovieDetail;

    if (provider.isLoadingDetail) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.detailErrorMessage != null || movie == null) {
      return Scaffold(
        body: Center(
          child: Text(
            provider.detailErrorMessage ?? 'No se pudo cargar la película',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final posterUrl = movie.posterPath != null
        ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
        : null;

    final genres = movie.genres.map((g) => g.name).whereType<String>().toList();
    final language = movie.originalLanguage ?? '—';
    final year = movie.releaseDate?.year.toString() ?? '—';
    final rating = movie.voteAverage?.toStringAsFixed(1) ?? '—';
    final synopsis = movie.overview ?? 'Sin descripción';

    return Scaffold(
      body: Stack(
        children: [
          if (posterUrl != null)
            ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black87, Colors.transparent, Colors.black87],
                  stops: [0.0, 0.5, 1.0],
                ).createShader(rect);
              },
              blendMode: BlendMode.darken,
              child: SizedBox.expand(
                child: Image.network(posterUrl, fit: BoxFit.cover),
              ),
            ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
              onPressed: () => context.router.pop(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    movie.title ?? 'Sin título',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _infoChip(year),
                      const SizedBox(width: 8),
                      _infoChip(language),
                      const SizedBox(width: 8),
                      _ratingChip(rating),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    genres.join(' • '),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Movie Plot',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        synopsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  if (provider.trailerKey != null)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              backgroundColor: Colors.black,
                              insetPadding: const EdgeInsets.all(16),
                              child: Stack(
                                children: [
                                  YoutubePlayerBuilder(
                                    player: YoutubePlayer(
                                      controller: YoutubePlayerController(
                                        initialVideoId: provider.trailerKey!,
                                        flags: const YoutubePlayerFlags(
                                          autoPlay: true,
                                          mute: false,
                                        ),
                                      ),
                                      showVideoProgressIndicator: true,
                                    ),
                                    builder: (context, player) => AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: player,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: IconButton(
                                      icon: const Icon(Icons.close,
                                          color: Colors.white),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.play_arrow, color: Colors.white),
                        label: const Text('Ver tráiler',
                            style: TextStyle(color: Colors.white)),
                        style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(color: Colors.white, width: 0.8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 223, 223, 223),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(text,
            style: const TextStyle(color: Colors.black, fontSize: 14)),
      );

  Widget _ratingChip(String rating) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.star, color: Colors.black, size: 16),
            const SizedBox(width: 4),
            Text(rating,
                style: const TextStyle(color: Colors.black, fontSize: 14)),
          ],
        ),
      );
}
