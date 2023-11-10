import 'package:flutter/material.dart';
import 'package:moviesapp/home_screen.dart';
import 'package:moviesapp/movie_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        MovieDetails.routeName: (context) {
          final movieId = ModalRoute.of(context)!.settings.arguments as int?;
          return MovieDetails(movieId: movieId ?? 0);
        },
      },
    );
  }
}
