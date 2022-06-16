

import 'package:flutter/material.dart';
import 'package:flutter_codigo5_movieapp/model/movie_model.dart';

import '../../pages/movie_detail_page.dart';

class ItemMovieWidget extends StatelessWidget {
  //const ItemMovieWidget({Key? key}) : super(key: key);

  MovieModel movie;

  ItemMovieWidget({
    required this.movie

});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        print("entrando al detalle de pelicula con id: ${movie.id}");
        Navigator.push(context, MaterialPageRoute(builder: (context)=> MovieDetailPage(Id: movie.id,)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: 16.0, horizontal: 14.0),
        width: double.infinity,
        height: height * 0.65,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(4, 4),
              blurRadius: 12.0,
            ),
          ],
          borderRadius: BorderRadius.circular(22.0),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              "http://image.tmdb.org/t/p/w500${movie.posterPath}",
            ),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(22),
                    bottomLeft: Radius.circular(22),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      movie.originalTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      height: 3,
                      width: 100,

                      decoration: BoxDecoration(
                        color: Color(0xff1FCEB5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      movie.overview,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 13.0,
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              color: Colors.white,
                              size: 14.0,
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              movie.releaseDate.toString().substring(0,10),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.thumb_up_alt,
                              color: Colors.white,
                              size: 14.0,
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              movie.voteCount.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.all(14.0),
                margin: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  movie.voteAverage.toString(),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
