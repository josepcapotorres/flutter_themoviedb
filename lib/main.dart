import 'package:flutter/material.dart';
import 'package:flutter_themoviedb/pages/movie_detail_page.dart';

import 'pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Películas",
      initialRoute: "/",
      routes: {
        "/" : (_) => HomePage(),
        "detail" : (_) => MovieDetailPage(),
      }
    );
  }
}
