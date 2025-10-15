import 'package:auto_route/annotations.dart';
import 'package:emovie/core/constants/app_colors.dart';
import 'package:emovie/modules/movies/presentation/widgets/recommended_section_widget.dart';
import 'package:emovie/modules/movies/presentation/widgets/trending_section_widget.dart';
import 'package:emovie/modules/movies/presentation/widgets/upcoming_section_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Center(
                child: Text(
                  'eMovie',
                  style: TextStyle(
                    color: AppColors.title,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 24),
              UpcomingSectionWidget(),
              SizedBox(height: 24),
              TrendingSectionWidget(),
              SizedBox(height: 24),
              RecommendedSectionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
