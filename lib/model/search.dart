// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  SearchModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    page: json["page"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  bool? adult;
  String? backdropPath;
  int? id;
  String? title;
  OriginalLanguage? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  MediaType? mediaType;
  double? popularity;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Result({
     this.adult,
     this.backdropPath,
     this.id,
     this.title,
     this.originalLanguage,
     this.originalTitle,
     this.overview,
     this.posterPath,
     this.mediaType,
     this.popularity,
     this.video,
     this.voteAverage,
     this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    id: json["id"],
    title: json["title"],
    originalLanguage: originalLanguageValues.map[json["original_language"]],
    originalTitle: json["original_title"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    mediaType: mediaTypeValues.map[json["media_type"]],
    popularity: json["popularity"]?.toDouble(),
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "id": id,
    "title": title,
    "original_language": originalLanguageValues.reverse[originalLanguage],
    "original_title": originalTitle,
    "overview": overview,
    "poster_path": posterPath,
    "media_type": mediaTypeValues.reverse[mediaType],
    "popularity": popularity,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

enum MediaType {
  MOVIE
}

final mediaTypeValues = EnumValues({
  "movie": MediaType.MOVIE
});

enum OriginalLanguage {
  EN,
  IT,
  TR
}

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "it": OriginalLanguage.IT,
  "tr": OriginalLanguage.TR
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
