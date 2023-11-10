import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:moviesapp/ApiManager.dart';
import 'package:moviesapp/GetFromApi/GetNewRelease.dart';
import 'package:moviesapp/GetFromApi/GetPopular.dart';
import 'package:moviesapp/NewReleases.dart';
import 'package:moviesapp/recomended.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff1A1A1A),
          selectedItemColor: Color(0xffB0A000),
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'HOME'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, color: Colors.grey), label: 'SEARCH'),
            BottomNavigationBarItem(
                icon: Icon(Icons.movie, color: Colors.grey), label: 'HOME'),
          ],
        ),
        backgroundColor: Color(0xff121312),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  ImageSlideshow(children: [
                    Image.asset(
                      'assets/images/R.jpeg',
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 1,
                      fit: BoxFit.fill,
                    ),
                  ]),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 16, top: 140),
                          child: Image.asset(
                            'assets/images/R.jpeg',
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.3,
                            fit: BoxFit.fill,
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 12, top: 240),
                            child: Text(
                              'THE EXPENDABLES',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 13),
                            child: Text(
                              '2019  PG-13  2h 7m',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              NewReleaseScreen(),
              Recomended()
            ],
          ),
        ));
  }
}
