import 'package:flutter/material.dart';

class RecommendedSectionWidget extends StatelessWidget {
  const RecommendedSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const titleColor = Colors.white;
    const subtitleColor = Colors.white70;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recomendados para ti',
          style: TextStyle(
            color: titleColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.7,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.grey.shade800,
              child: Center(
                child: Text(
                  'Imagen ${index + 1}',
                  style: TextStyle(color: subtitleColor),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
