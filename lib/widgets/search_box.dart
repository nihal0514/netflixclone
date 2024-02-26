import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix/bloc/netflix_bloc.dart';

import '../model/movie.dart';
import '../model/search.dart';
import '../utils/utils.dart';
import 'netflix_bottom_sheet.dart';
import 'poster_image.dart';

class SearchBox extends StatelessWidget {
  const SearchBox(
      {super.key,
        required this.movie,
        this.fill = false,
        this.padding});

  final Result movie;
  final bool fill;
  final EdgeInsets? padding;


  @override
  Widget build(BuildContext context) {
    final configuration = context.watch<ConfigurationBloc>().state;
    final imageAvailable = movie.posterPath != null;
    final thumbnailProvider = (imageAvailable
        ? CachedNetworkImageProvider(
        '${configuration.data?.images.baseUrl}/${configuration.data?.images.posterSizes[1]}${movie.posterPath}')
        : const AssetImage(
      'assets/netflix_symbol.png',
    )) as ImageProvider;
    return Padding(
      padding:
      padding ?? const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),

      child: InkWell(
        onTap: (){
          showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              backgroundColor: bottomSheetColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
              ),
              builder: (context) {
                return SearchNetflixBottomSheet(
                  thumbnail: thumbnailProvider,
                  movie: movie,
                );
              });
        },
        child: Stack(
          children: [
            fill
                ? Positioned.fill(
                child:
                SearchPosterImage(movie: movie, width: 200.0, height: 220.0))
                : SearchPosterImage(movie: movie, width: 2000.0, height: 220.0),
            Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  'assets/netflix_symbol.png',
                  width: 24.0,
                )),

          ],
        ),
      ),
    );
  }
}
