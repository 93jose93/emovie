import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const posterUrl =
        'https://image.tmdb.org/t/p/w500/k7eYdWvhYQyRQoU2TB2A2Xu2TfD.jpg';
    const title = 'Her';
    const year = '2013';
    const rating = 8.0;
    const genres = ['Heartfelt', 'Romance', 'Sci-fi', 'Drama'];
    const synopsis =
        'In a near future, a lonely writer develops an unlikely relationship with an operating system designed to meet his every need.';

    return Scaffold(
      body: Stack(
        children: [
          // Fondo con imagen
          SizedBox.expand(
            child: Image.network(
              posterUrl,
              fit: BoxFit.cover,
            ),
          ),

          // Capa oscura para contraste
          Container(
            color: Colors.black.withOpacity(0.6),
          ),

          // Contenido principal
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Año y calificación
                Row(
                  children: [
                    Text(
                      year,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    Text(
                      rating.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Géneros
                Wrap(
                  spacing: 8,
                  children: genres
                      .map((genre) => Chip(
                            label: Text(genre),
                            backgroundColor: Colors.white10,
                            labelStyle: const TextStyle(color: Colors.white),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 24),

                // Sinopsis
                const Text(
                  synopsis,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 32),

                // Botón
                ElevatedButton.icon(
                  onPressed: () {
                    // Acción para ver tráiler
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Ver tráiler'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
