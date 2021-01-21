import 'package:flutter/material.dart';
import 'package:flutter_themoviedb/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<MovieModel> movies;
  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );
  final Function nextPage;

  MovieHorizontal({@required this.movies, @required this.nextPage});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: screenSize.height * 0.28,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (context, i) => _card(context, movies[i]),
      ),
    );
  }

  Widget _card(BuildContext context, MovieModel movie) {
    movie.uniqueId = "${ movie.id }-poster";

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "detail", arguments: movie);
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        child: Column(
          children: [
            Hero(
              tag: movie.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage("assets/img/no-image.jpg"),
                  image: NetworkImage(movie.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
