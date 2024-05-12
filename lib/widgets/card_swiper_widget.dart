import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_themoviedb/models/movie_model.dart';

class CustomCardSwiper extends StatelessWidget {
  final List<MovieModel> movies;

  const CustomCardSwiper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Container(
      padding: const EdgeInsets.only(top: 5),
      width: screenSize.width * 0.7,
      height: screenSize.height * 0.5,
      child: CardSwiper(
        cardBuilder: (BuildContext context, int index, _, __) {
          movies[index].uniqueId = "${movies[index].id}-card";

          return Hero(
            tag: movies[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, "detail",
                    arguments: movies[index]),
                child: FadeInImage(
                  image: NetworkImage(movies[index].getPosterImg()),
                  placeholder: const AssetImage("assets/img/no-image.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        cardsCount: movies.length,
      ),
    );
  }
}
