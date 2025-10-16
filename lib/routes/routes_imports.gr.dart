// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:emovie/modules/movies/presentation/screens/home_screen.dart'
    as _i1;
import 'package:emovie/modules/movies/presentation/screens/movie_detail_screen.dart'
    as _i2;
import 'package:flutter/material.dart' as _i4;

/// generated route for
/// [_i1.HomeScreen]
class HomeScreenRoute extends _i3.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i3.PageRouteInfo>? children})
    : super(HomeScreenRoute.name, initialChildren: children);

  static const String name = 'HomeScreenRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomeScreen();
    },
  );
}

/// generated route for
/// [_i2.MovieDetailScreen]
class MovieDetailScreenRoute
    extends _i3.PageRouteInfo<MovieDetailScreenRouteArgs> {
  MovieDetailScreenRoute({
    _i4.Key? key,
    required int movieId,
    List<_i3.PageRouteInfo>? children,
  }) : super(
         MovieDetailScreenRoute.name,
         args: MovieDetailScreenRouteArgs(key: key, movieId: movieId),
         initialChildren: children,
       );

  static const String name = 'MovieDetailScreenRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MovieDetailScreenRouteArgs>();
      return _i2.MovieDetailScreen(key: args.key, movieId: args.movieId);
    },
  );
}

class MovieDetailScreenRouteArgs {
  const MovieDetailScreenRouteArgs({this.key, required this.movieId});

  final _i4.Key? key;

  final int movieId;

  @override
  String toString() {
    return 'MovieDetailScreenRouteArgs{key: $key, movieId: $movieId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MovieDetailScreenRouteArgs) return false;
    return key == other.key && movieId == other.movieId;
  }

  @override
  int get hashCode => key.hashCode ^ movieId.hashCode;
}
