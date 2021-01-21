import 'dart:async';
import 'dart:convert';

import 'package:flutter_themoviedb/models/character_model.dart';
import 'package:flutter_themoviedb/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = "5e63629e7a6d66be730187029d96cba7";
  String _url = "api.themoviedb.org";
  String _language = "en-us";
  int _popularsPage = 0;
  List<MovieModel> _populars = new List();
  bool _loading = false;

  final _popularsStreamController =
      StreamController<List<MovieModel>>.broadcast();

  Function(List<MovieModel>) get popularsSink =>
      _popularsStreamController.sink.add;

  Stream<List<MovieModel>> get popularsStream =>
      _popularsStreamController.stream;

  Future<List<MovieModel>> _processResponse(Uri url) async {
    final response = await http.get(url);
    final decodedData = jsonDecode(response.body);
    final movies = MoviesModel.fromJsonList(decodedData["results"]);

    return movies.items;
  }

  Future<List<MovieModel>> getNowPlaying() async {
    final url = Uri.https(_url, "3/movie/now_playing", {
      "api_key": _apiKey,
      "language": _language,
    });

    return await _processResponse(url);
  }

  Future<List<MovieModel>> getPopulars() async {
    if (_loading) {
      return [];
    }

    _loading = true;

    _popularsPage++;

    final url = Uri.https(_url, "3/movie/popular", {
      "api_key": _apiKey,
      "language": _language,
      "page": "$_popularsPage",
    });

    final response = await _processResponse(url);

    _populars.addAll(response);

    popularsSink(_populars);

    _loading = false;

    return response;
  }

  Future<List<CharacterModel>> getCast(String movieId) async {
    final url = Uri.https(_url, "3/movie/$movieId/credits", {
      "api_key": _apiKey,
      "language": _language,
    });

    final response = await http.get(url);
    final decodedData = jsonDecode(response.body);
    final cast = Cast.fromJsonList(decodedData["cast"]);

    return cast.characters;
  }

  Future<List<MovieModel>> searchMovie(String query) async {
    final url = Uri.https(_url, "3/search/movie", {
      "api_key": _apiKey,
      "language": _language,
      "query": query,
    });

    return await _processResponse(url);
  }

  void dispose() {
    _popularsStreamController?.close();
  }
}
