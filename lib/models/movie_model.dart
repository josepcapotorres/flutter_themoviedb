class MoviesModel {
  List<MovieModel> items = new List();

  MoviesModel();

  MoviesModel.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (final item in jsonList) {
      final movie = new MovieModel.fromJsonMap(item);
      items.add(movie);
    }
  }
}

class MovieModel {
  String uniqueId;
  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  MovieModel({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

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

  getPosterImg() {
    if (posterPath == null) {
      return "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png";
    } else {
      return "https://image.tmdb.org/t/p/w500/$posterPath";
    }
  }

  getBackgroundImg() {
    if (posterPath == null) {
      return "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png";
    } else {
      return "https://image.tmdb.org/t/p/w500/$backdropPath";
    }
  }
}
