import 'dart:convert';

UpcomingModel upcomingModelFromJson(String str) =>
    UpcomingModel.fromJson(json.decode(str));

String upcomingModelToJson(UpcomingModel data) => json.encode(data.toJson());

class UpcomingModel {
  UpcomingModel({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final Dates? dates;
  final int? page;
  final List<Result> results;
  final int? totalPages;
  final int? totalResults;

  factory UpcomingModel.fromJson(Map<String, dynamic> json) {
    return UpcomingModel(
      dates: json["dates"] == null ? null : Dates.fromJson(json["dates"]),
      page: json["page"],
      results: json["results"] == null
          ? []
          : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
    );
  }

  Map<String, dynamic> toJson() => {
        "dates": dates?.toJson(),
        "page": page,
        "results": results.map((x) => x.toJson()).toList(),
        "total_pages": totalPages,
        "total_results": totalResults,
      };

  @override
  String toString() {
    return "$dates, $page, $results, $totalPages, $totalResults";
  }
}

class Dates {
  Dates({
    required this.maximum,
    required this.minimum,
  });

  final DateTime? maximum;
  final DateTime? minimum;

  factory Dates.fromJson(Map<String, dynamic> json) {
    return Dates(
      maximum: DateTime.tryParse(json["maximum"] ?? ""),
      minimum: DateTime.tryParse(json["minimum"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "maximum": formatDate(maximum),
        "minimum": formatDate(minimum),
      };

  @override
  String toString() {
    return "$maximum, $minimum";
  }
}

class Result {
  Result({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool? adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      genreIds: json["genre_ids"] == null
          ? []
          : List<int>.from(json["genre_ids"].map((x) => x)),
      id: json["id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: (json["popularity"] is int)
          ? (json["popularity"] as int).toDouble()
          : json["popularity"],
      posterPath: json["poster_path"],
      releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
      title: json["title"],
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
        "genre_ids": genreIds,
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": formatDate(releaseDate),
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  @override
  String toString() {
    return "$adult, $backdropPath, $genreIds, $id, $originalLanguage, $originalTitle, $overview, $popularity, $posterPath, $releaseDate, $title, $video, $voteAverage, $voteCount";
  }
}

/// Función auxiliar para formatear fechas
String? formatDate(DateTime? date) {
  if (date == null) return null;
  return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}
