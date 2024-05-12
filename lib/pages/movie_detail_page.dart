import 'package:flutter/material.dart';
import 'package:flutter_themoviedb/models/character_model.dart';
import 'package:flutter_themoviedb/models/movie_model.dart';
import 'package:flutter_themoviedb/providers/movies_provider.dart';

class MovieDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)?.settings.arguments as MovieModel?;

    if (movie == null) {
      return const Center(child: Text("Movie not found"));
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _createAppbar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 10),
              _posterTitle(context, movie),
              _description(movie),
              _createCasting(movie),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _createAppbar(MovieModel movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      foregroundColor: Colors.white,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.fullBackdropPath),
          placeholder: const AssetImage("assets/img/loading.gif"),
          fadeInDuration: const Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle(BuildContext context, MovieModel movie) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: NetworkImage(movie.getPosterImg()),
                height: 150,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  movie.originalTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    const Icon(Icons.star_border),
                    Text(
                      movie.voteAverage.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _description(MovieModel movie) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _createCasting(MovieModel movie) {
    final movieProvider = MoviesProvider();

    return FutureBuilder(
      future: movieProvider.getCast(movie.id.toString()),
      builder: (context, AsyncSnapshot<List<CharacterModel>> snapshot) {
        if (snapshot.hasData) {
          return _createCharactersPageView(snapshot.data!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _createCharactersPageView(List<CharacterModel> characters) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemCount: characters.length,
        itemBuilder: (context, i) => _characterCard(characters[i]),
      ),
    );
  }

  Widget _characterCard(CharacterModel character) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              height: 150,
              image: NetworkImage(character.getPhoto()),
              placeholder: const AssetImage("assets/img/no-image.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            character.name,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
