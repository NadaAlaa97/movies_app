import 'package:flutter/material.dart';
import 'ApiManager.dart';
import 'GetFromApi/GetMovieDetails.dart';
import 'GetFromApi/GetSimilarMovies.dart';

class MovieDetails extends StatefulWidget {
  static const String routeName = 'MovieDetails';
  final int movieId;

  MovieDetails({required this.movieId, Key? key}) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState(movieId: movieId);
}

class _MovieDetailsState extends State<MovieDetails> {
  final int movieId;
  GetMovieDetails? movieDetails;
  Future<GetSimilarMovies>? similarMovies;

  _MovieDetailsState({required this.movieId});

  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
    similarMovies = ApiManager.getSimilar(movieId.toString());
  }

  Future<void> fetchMovieDetails() async {
    try {
      GetMovieDetails details =
          await ApiManager.getMovieDetails(movieId.toString());
      setState(() {
        movieDetails = details;
      });
    } catch (e) {
      print('Error fetching movie details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (movieDetails == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff1A1A1A),
        selectedItemColor: Color(0xffB0A000),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.grey),
            label: 'SEARCH',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie, color: Colors.grey),
            label: 'MOVIE',
          ),
        ],
      ),
      backgroundColor: Color(0xff121312),
      appBar: AppBar(
        title: Text(movieDetails?.title ?? ""),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  "https://image.tmdb.org/t/p/w500${movieDetails?.posterPath}" ??
                      "",
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Icon(
                  Icons.play_circle_filled,
                  size: 60,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movieDetails?.title ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${movieDetails?.releaseDate} · ${movieDetails?.genres?.map((g) => g.name).join(', ')}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w500${movieDetails?.posterPath}" ??
                        "",
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          movieDetails?.genres?.map((g) => g.name).join(', ') ??
                              "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movieDetails?.overview ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '${movieDetails?.voteAverage ?? ""}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 16),
              decoration: BoxDecoration(color: Color(0xff282A28)),
              child: FutureBuilder<GetSimilarMovies>(
                future: similarMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'More Like This',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: ListView.builder(
                              itemCount: snapshot.data?.results?.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      right: 8, bottom: 12, top: 4),
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Image.network(
                                            "https://image.tmdb.org/t/p/w500" +
                                                (snapshot.data!.results![index]
                                                        .posterPath ??
                                                    ""),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            fit: BoxFit.cover,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                              top: 8,
                                              bottom: 8,
                                            ),
                                            child: Text(
                                              snapshot.data!.results![index]
                                                      .title ??
                                                  "",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    }
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
