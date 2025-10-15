import 'package:flutter/material.dart';

class TrendingSectionWidget extends StatelessWidget {
  const TrendingSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const titleColor = Colors.white;
    const subtitleColor = Colors.white70;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tendencia',
          style: TextStyle(
            color: titleColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: 12),
                color: Colors.grey.shade800,
                child: Center(
                  child: Text(
                    'Poster ${index + 1}',
                    style: TextStyle(color: subtitleColor),
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
