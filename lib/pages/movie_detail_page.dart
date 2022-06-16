import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_movieapp/model/person_model.dart';
import 'package:flutter_codigo5_movieapp/model/reviews_model.dart';
import 'package:flutter_codigo5_movieapp/ui/general/colors.dart';
import 'package:flutter_codigo5_movieapp/ui/widgets/cast_detail_widget.dart';
import 'package:flutter_codigo5_movieapp/ui/widgets/item_cast_widget.dart';
import 'package:flutter_codigo5_movieapp/ui/widgets/item_review_widget.dart';
import 'package:flutter_codigo5_movieapp/ui/widgets/title_description_widget.dart';
import 'package:flutter_codigo5_movieapp/pages/new_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';

import '../model/cast_model.dart';
import '../model/image_model.dart';
import '../model/movie_detail_model.dart';
import '../services/api_service.dart';
import '../ui/widgets/progress_indicator_widget.dart';

class MovieDetailPage extends StatefulWidget {
  int Id;
  MovieDetailPage({required this.Id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final APIService _service = APIService();
  MovieDetailModel movieDetail = MovieDetailModel(
      id: 0,
      adult: false,
      backdropPath: "",
      belongsToCollection: BelongsToCollection(
          backdropPath: "", id: 0, name: "", posterPath: ""),
      budget: 0,
      genres: [],
      homepage: "",
      imdbId: "",
      originalLanguage: "",
      originalTitle: "",
      overview: "",
      popularity: 0,
      posterPath: "",
      productionCompanies: [],
      productionCountries: [],
      releaseDate: DateTime.now(),
      revenue: 0,
      runtime: 0,
      spokenLanguages: [],
      status: "",
      tagline: "",
      title: "",
      video: false,
      voteAverage: 0,
      voteCount: 0);
  bool isLoading = true;
  List<CastModel> castModelList = [];
  List<ReviewsModel> reviewsModelList = [];
  PersonModel? personModel;
  List<ImageModel> images = [];

  getData() async {
    movieDetail = await _service.getDataMoviesDetail(widget.Id);
    castModelList = await _service.getCast(widget.Id);
    reviewsModelList = await _service.getReviews(widget.Id);
    images = await _service.getImages(widget.Id);
    isLoading = false;
    setState(() {
      print(movieDetail.backdropPath);
    });
  }

  getDataMovie() async {
    print("Estoy por traer los detaller de la pelicula con id ${widget.Id}");
    /*
    _service.getDataMoviesDetail(widget.Id).then(( MovieDetailModel value)  {
      movieDetail =   value;
      print(movieDetail.backdropPath);
      setState(() {});
    });
*/
    movieDetail = await _service.getDataMoviesDetail(widget.Id);
    isLoading = false;
    setState(() {
      print(movieDetail.backdropPath);
    });
  }

  getDataCast() async {
    print("Estoy por traer los actores de la pelicula con id ${widget.Id}");

    castModelList = await _service.getCast(widget.Id);
    isLoading = false;
    setState(() {
      print(movieDetail.backdropPath);
    });
  }

  List<Widget> getGenres() {
    List<Widget> genresList = [];

    movieDetail.genres.forEach((element) {
      genresList.add(Chip(
          label: Text(
            element.name,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0))));
    });
    return genresList;
  }

  void _launchUrl(Uri url) async {
    if (!await launchUrl(url)) throw 'No fue posible ir a $url';
  }

  showDetailCast(int Id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CastDetailWidget(
          Id: Id,
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*
    getDataMovie();
    getDataCast();
     */
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.Id);
    return Scaffold(
        backgroundColor: kBrandPrimaryColor,
        body: !isLoading
            ? CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(
                      movieDetail!.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    centerTitle: true,
                    expandedHeight: 200.0,
                    elevation: 0,
                    backgroundColor: kBrandPrimaryColor,
                    flexibleSpace: FlexibleSpaceBar(
                      // title: Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      //   child: Text(
                      //     "Diego jlkajsdkasd sadsadsad asdasdasdsad asdasds",
                      //     maxLines: 1,
                      //     style: TextStyle(
                      //       fontSize: 12.0,
                      //     ),
                      //   ),
                      // ),
                      // // titlePadding: EdgeInsets.symmetric(horizontal: 50.0),
                      // centerTitle: true,
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            "http://image.tmdb.org/t/p/w500${movieDetail!.backdropPath}",
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    kBrandPrimaryColor.withOpacity(1),
                                    kBrandPrimaryColor.withOpacity(0.0),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    floating: false,
                    snap: false,
                    pinned: true,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 14.0),
                          child: Row(
                            children: [
                              Container(
                                height: 160,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "http://image.tmdb.org/t/p/w500/${movieDetail!.posterPath}",
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12.0,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          color: Colors.white54,
                                          size: 14.0,
                                        ),
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        Text(
                                          movieDetail!.releaseDate
                                              .toString()
                                              .substring(0, 10),
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 13.0),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    Text(
                                      movieDetail!.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          color: Colors.white54,
                                          size: 14.0,
                                        ),
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        Text(
                                          "${movieDetail!.runtime} min",
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 13.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: ElevatedButton.icon(
                            icon: Icon(
                              Icons.play_circle_outline,
                              color: kBrandPrimaryColor,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewPage()));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: kBrandSecondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            label: Text(
                              "Movie trailers",
                              style: TextStyle(
                                color: kBrandPrimaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleDescriptionWidget(
                                title: "Overview",
                              ),
                              Text(
                                movieDetail!.overview,
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 50.0,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    final Uri url =
                                        Uri.parse(movieDetail!.homepage);
                                    print(movieDetail!.homepage);
                                    _launchUrl(url);
                                  },
                                  icon: const Icon(
                                    Icons.link,
                                    color: kBrandPrimaryColor,
                                  ),
                                  label: const Text(
                                    "Home page",
                                    style: TextStyle(
                                      color: kBrandPrimaryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: kBrandSecondaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TitleDescriptionWidget(
                                title: "Genres",
                              ),
                              Wrap(
                                spacing: 8,
                                children: movieDetail!.genres
                                    .map((e) => Chip(
                                        label: Text(
                                          e.name,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0))))
                                    .toList(),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TitleDescriptionWidget(
                                title: "Cast",
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                child: Row(
                                  children: castModelList
                                      .map((e) => GestureDetector(
                                          onTap: () {
                                            showDetailCast(e.id);
                                          },
                                          child: ItemCastWidget(castModel: e)))
                                      .toList(),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TitleDescriptionWidget(
                                title: "Images",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                childAspectRatio: 1.5,
                                padding: EdgeInsets.zero,
                                children: images
                                    .map(
                                      (e) => PinchZoomImage(
                                        image: Image.network(
                                          "https://image.tmdb.org/t/p/w500${e.filePath}",
                                          fit: BoxFit.cover,
                                        ),
                                        zoomedBackgroundColor:
                                            Color.fromRGBO(240, 240, 240, 1.0),
                                        hideStatusBarWhileZooming: true,
                                        onZoomStart: () {
                                          print('Zoom started');
                                        },
                                        onZoomEnd: () {
                                          print('Zoom finished');
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TitleDescriptionWidget(
                                title: "Reviews",
                              ),
                              Column(
                                children: reviewsModelList
                                    .map((e) => ItemReviewWidget(
                                          reviewsModel: e,
                                        ))
                                    .toList()
                                /*[
                                  ItemReviewWidget(),
                                  ItemReviewWidget(),
                                  ItemReviewWidget(),
                                  ItemReviewWidget(),
                                ]*/
                                ,
                              ),
                              const SizedBox(
                                height: 200,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const ProgressIndicatorWidget());
  }
}
