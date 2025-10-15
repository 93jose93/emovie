import 'dart:convert';

TrendingWeekModel trendingWeekModelFromJson(String str) =>
    TrendingWeekModel.fromJson(json.decode(str));

String trendingWeekModelToJson(TrendingWeekModel data) =>
    json.encode(data.toJson());

class TrendingWeekModel {
  TrendingWeekModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int? page;
  final List<Result> results;
  final int? totalPages;
  final int? totalResults;

  factory TrendingWeekModel.fromJson(Map<String, dynamic> json) {
    return TrendingWeekModel(
      page: json["page"],
      results: json["results"] == null
          ? []
          : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
    );
  }

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": results.map((x) => x.toJson()).toList(),
        "total_pages": totalPages,
        "total_results": totalResults,
      };

  @override
  String toString() {
    return "$page, $results, $totalPages, $totalResults";
  }
}

class Result {
  Result({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool? adult;
  final String? backdropPath;
  final int? id;
  final String? title;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String? mediaType;
  final String? originalLanguage;
  final List<int> genreIds;
  final double? popularity;
  final DateTime? releaseDate;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      id: json["id"],
      title: json["title"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      mediaType: json["media_type"],
      originalLanguage: json["original_language"],
      genreIds: json["genre_ids"] == null
          ? []
          : List<int>.from(json["genre_ids"].map((x) => x)),
      popularity: (json["popularity"] is int)
          ? (json["popularity"] as int).toDouble()
          : json["popularity"],
      releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
      video: json["video"],
      voteAverage: (json["vote_average"] is int)
          ? (json["vote_average"] as int).toDouble()
          : json["vote_average"],
      voteCount: json["vote_count"],
    );
  }

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaType,
        "original_language": originalLanguage,
        "genre_ids": genreIds,
        "popularity": popularity,
        "release_date": formatDate(releaseDate),
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  @override
  String toString() {
    return "$adult, $backdropPath, $id, $title, $originalTitle, $overview, $posterPath, $mediaType, $originalLanguage, $genreIds, $popularity, $releaseDate, $video, $voteAverage, $voteCount";
  }
}

/// Función auxiliar para formatear fechas
String? formatDate(DateTime? date) {
  if (date == null) return null;
  return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}
