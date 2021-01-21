import 'package:flutter/material.dart';
import 'package:flutter_themoviedb/models/movie_model.dart';
import 'package:flutter_themoviedb/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  String selection = "";
  final _moviesProvider = MoviesProvider();

  final movies = [
    "Spiderman",
    "Aquaman",
    "Batman",
    "Shazam!",
    "Ironman 1",
    "Ironman 2",
    "Ironman 3",
    "Ironman 4",
    "Ironman 5",
    "Capitan America",
  ];

  final recentMovies = [
    "Spiderman",
    "Capitan America",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // AppBar actions. Such as clear text icon
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading (left) icon search bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // It builds the results we will show
    return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.blueAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // It shows suggestions when a user is writing

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: _moviesProvider.searchMovie(query),
      builder: (_, AsyncSnapshot<List<MovieModel>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;

          return ListView(
            children: movies.map((m) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(m.getPosterImg()),
                  placeholder: AssetImage("assets/img/no-image.jpg"),
                  width: 50,
                  fit: BoxFit.contain,
                ),
                title: Text(m.title),
                subtitle: Text(m.originalTitle),
                onTap: () {
                  close(context, null);
                  m.uniqueId = "";
                  Navigator.pushNamed(context, "detail", arguments: m);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
