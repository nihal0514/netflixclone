import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix/widgets/search_box.dart';
import 'package:shimmer/shimmer.dart';

import '../bloc/netflix_bloc.dart';
import '../model/search.dart';
import '../widgets/movie_box.dart';

class MovieSearch extends StatefulWidget {
  const MovieSearch({super.key});

  @override
  State<MovieSearch> createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  final movieSearchTextController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    movieSearchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        margin: EdgeInsets.only(left:20,right: 20,top: 10),
        child: Column(
          children: [

            TextField(
              controller: movieSearchTextController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: 'Enter Movie Name',
              ),
              onChanged: (text){
                context.read<SearchListResult>().add((searchEvent(text)));

              },
            ),
            Builder(builder: (context) {
              final movies =
                  context.watch<SearchListResult>().state;
              if(movies is searchListResult){
                return   Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: movies.searchResultList.length,
                    gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 8.0
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final movie = movies.searchResultList[index];
                      return SearchBox(
                        key: ValueKey(movie.id),
                        movie: movie,
                      );
                    },
                  ),
                );
              }
              return SizedBox();
            }),

          ],
        ),
      ),
    );
  }
}
