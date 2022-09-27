import 'dart:convert';

class Movies {
  Movies({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  get fullImagePoster {
    // https://image.tmdb.org/t/p/w500
    if (posterPath != null) {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    }

    return 'https://thumbs.dreamstime.com/b/print-209555561.jpg';
  }

  get fullBackdropPath {
    // https://image.tmdb.org/t/p/w500
    if (backdropPath != null) {
      return 'https://image.tmdb.org/t/p/w500$backdropPath';
    }

    return 'https://thumbs.dreamstime.com/b/print-209555561.jpg';
  }

  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String? releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  factory Movies.fromJson(String str) => Movies.fromMap(json.decode(str));

  factory Movies.fromMap(Map<String, dynamic> json) => Movies(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}
