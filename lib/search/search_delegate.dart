import 'package:flutter/material.dart';
import 'package:flutter_themoviedb/models/movie_model.dart';
import 'package:flutter_themoviedb/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  String selection = "";
  final _moviesProvider = MoviesProvider();
  List<MovieModel> _moviesList = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    // AppBar actions. Such as clear text icon
    return [
      IconButton(
        icon: const Icon(Icons.clear),
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
    return ListView(
      children: _moviesList.map((m) {
        return ListTile(
          leading: FadeInImage(
            image: NetworkImage(m.getPosterImg()),
            placeholder: const AssetImage("assets/img/no-image.jpg"),
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
          _moviesList = snapshot.data!;

          return ListView(
            children: _moviesList.map((m) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(m.fullPosterImg),
                  placeholder: const AssetImage("assets/img/no-image.jpg"),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
