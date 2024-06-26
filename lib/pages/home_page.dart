import 'package:flutter/material.dart';
import 'package:flutter_themoviedb/models/movie_model.dart';
import 'package:flutter_themoviedb/providers/movies_provider.dart';
import 'package:flutter_themoviedb/search/search_delegate.dart';
import 'package:flutter_themoviedb/widgets/card_swiper_widget.dart';
import 'package:flutter_themoviedb/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final _moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    _moviesProvider.getPopulars();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Now playing movies"),
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperCards(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: _moviesProvider.getNowPlaying(),
      builder: (_, AsyncSnapshot<List<MovieModel>> snapshot) {
        if (snapshot.hasData) {
          return CustomCardSwiper(
            movies: snapshot.data!,
          );
        } else {
          return Container(
            height: 100,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Populars",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          StreamBuilder(
            stream: _moviesProvider.popularsStream,
            builder: (_, AsyncSnapshot<List<MovieModel>> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  movies: snapshot.data!,
                  nextPage: _moviesProvider.getPopulars,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
