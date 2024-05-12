class MoviesModel {
  List<MovieModel> items = [];

  MoviesModel();

  MoviesModel.fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return;

    items = jsonList.map((e) => MovieModel.fromJsonMap(e)).toList();
  }
}

class MovieModel {
  late String uniqueId;
  late int voteCount;
  late int id;
  late bool video;
  late double voteAverage;
  late String title;
  late double popularity;
  String? posterPath;
  late String originalLanguage;
  late String originalTitle;
  late List<int> genreIds;
  String? backdropPath;
  late bool adult;
  late String overview;
  late String releaseDate;

  MovieModel.fromJsonMap(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    id = json['id'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
    title = json['title'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  String getPosterImg() {
    if (posterPath == null) {
      return "https://icons8.com/icon/122635/no-image";
    } else {
      return "https://image.tmdb.org/t/p/w500$posterPath";
    }
  }

  String get fullBackdropPath {
    if (backdropPath != null) {
      return 'https://image.tmdb.org/t/p/w500$backdropPath ';
    }

    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  String get fullPosterImg {
    if (posterPath != null) {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    }

    return 'https://i.stack.imgur.com/GNhxO.png';
  }
}
