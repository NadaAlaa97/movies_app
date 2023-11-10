import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp/ApiManager.dart';

import 'GetFromApi/GetTopRelated.dart';
import 'movie_details.dart';

class Recomended extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
      Navigator.pushNamed(context, MovieDetails.routeName);
    },
    child:  Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(color: Color(0xff282A28)),
      child: FutureBuilder<GetTopRelated>(
        future: ApiManager.getTopRelated(),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // New release text
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Recommended',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8,top: 8),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        color: Color(0xff121312),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetails(
                                      movieId: snapshot.data!.results![index].id?? 0,
                                    ),
                                  ),
                                );

                              },
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w500"+ snapshot.data!.results![index].posterPath!,
                                height: MediaQuery.of(context).size.height * 0.20,
                                width: MediaQuery.of(context).size.width * 0.32,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 8),
                              child: Row(
                                children: [
                                  Icon(Icons.star, color: Colors.yellow),
                                  SizedBox(width: 8),
                                  Text(
                                    snapshot.data!.results![index].voteAverage.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                top: 8,
                                bottom: 8,
                              ),
                              child: Text(
                                snapshot.data!.results![index].title??"",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //     left: 8.0,
                            //     top: 0,
                            //     bottom: 8,
                            //   ),
                            //   child: Row(
                            //     children: [
                            //       Text(
                            //         snapshot.data!.results![index].releaseDate??"",
                            //         style: TextStyle(
                            //           color: Colors.grey,
                            //           fontSize: 12,
                            //         ),
                            //       ),
                            //       SizedBox(width: 8),
                            //       Text(
                            //         snapshot.data!.results![index].popularity.toString()??"",
                            //         style: TextStyle(
                            //           color: Colors.grey,
                            //           fontSize: 12,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: 8,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          );
        },

      ),
    ),
    );
  }

}