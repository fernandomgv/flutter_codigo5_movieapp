import 'dart:convert';
import 'package:flutter_codigo5_movieapp/model/cast_model.dart';
import 'package:flutter_codigo5_movieapp/model/genres_model.dart';
import 'package:flutter_codigo5_movieapp/model/person_model.dart';
import 'package:flutter_codigo5_movieapp/model/reviews_model.dart';
import 'package:http/http.dart' as http;

import '../model/image_model.dart';
import '../model/movie_detail_model.dart';
import '../model/movie_model.dart';
import '../utils/constants.dart';

class APIService {
  int page = 1;

  //static const String apiKey="66222b0abff792c81b1648e16c552713";
  String language = "es-PE";

  Future<List<MovieModel>> getDataMovies({String? withGenres = null}) async {
    List<MovieModel> movieModelList = [];
    List movieList = [];
    String url =
        "$pathProduction/discover/movie?api_key=$apiKey&language=$language&sort_by=popularity.desc&include_adult=false&include_video=true&page=$page&with_watch_monetization_types=flatrate";
    if (withGenres != null) {
      url =
      "$pathProduction/discover/movie?api_key=$apiKey&language=$language&sort_by=popularity.desc&include_adult=false&include_video=true&page=$page&with_watch_monetization_types=flatrate&with_genres=$withGenres";
    }
    Uri _uri = Uri.parse(
        "$pathProduction/discover/movie?api_key=$apiKey&language=$language&sort_by=popularity.desc&include_adult=false&include_video=true&page=$page&with_watch_monetization_types=flatrate");
    //https://api.themoviedb.org/3/discover/movie?api_key=66222b0abff792c81b1648e16c552713&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=16&with_watch_monetization_types=flatrate

    //Map<String,String> headers = {'Authorization':'Basic YWRtaW5pc3RyYXRvcjpNZjk5Nzk5NSQ='};

    http.Response response =
    await http.get(_uri); //http.get(_uri,headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      movieList = myMap["results"];
      movieModelList = movieList.map((e) => MovieModel.fromJson(e)).toList();
      print("retornando movieModelList con ${movieModelList.length} elementos");
      return movieModelList;
    }
    return [];
  }

  Future<List<GenresModel>> getDataGenres() async {
    List<GenresModel> genresModelList = [];
    Uri _uri = Uri.parse(
        "https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=es-PE");

    http.Response response =
    await http.get(_uri); //http.get(_uri,headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      List genresList = myMap["genres"];
      genresModelList = genresList.map((e) => GenresModel.fromJson(e)).toList();
      print(
          "retornando genresModelList con ${genresModelList.length} elementos");
      return genresModelList;
    }
    return [];
  }

  Future<MovieDetailModel> getDataMoviesDetail(int Id) async {
    MovieDetailModel movieDetailModel;
    String url =
        "https://api.themoviedb.org/3/movie/$Id?api_key=$apiKey&language=en-US";
    print("URL: ${url}");
    Uri _uri = Uri.parse(url);
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      movieDetailModel = MovieDetailModel.fromJson(myMap);
      print(movieDetailModel.title);
      return movieDetailModel;
    }
    return MovieDetailModel(
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
        voteCount: 0
    );
  }

  Future<List<CastModel>> getCast(int movieId) async {
    String path = "$pathProduction/movie/$movieId/credits?api_key=$apiKey&language=en-US";
    Uri _uri = Uri.parse(path);
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      List cast = myMap["cast"];
      List<CastModel> castModelList = cast.map((e) => CastModel.fromJson(e))
          .toList();
      return castModelList;
    }
    return [];
  }

  Future<List<ReviewsModel>> getReviews(int movieId) async {
    String path = "$pathProduction/movie/$movieId/reviews?api_key=$apiKey&language=en-US";
    Uri _uri = Uri.parse(path);
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      List reviews = myMap["results"];
      List<ReviewsModel> reviewsModel = reviews.map((e) =>
          ReviewsModel.fromJson(e)).toList();
      return reviewsModel;
    }
    return [];
  }

  Future<PersonModel?> getDataPerson(int Id) async {
    PersonModel personModel;
    String url =
        "https://api.themoviedb.org/3/person/$Id?api_key=$apiKey&language=en-US";

    Uri _uri = Uri.parse(url);
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      personModel = PersonModel.fromJson(myMap);
      return personModel;
    }
    return null;
  }

  Future<List<ImageModel>> getImages(int movieId) async {
    String path = "$pathProduction/movie/$movieId/images?api_key=$apiKey";
    Uri _uri = Uri.parse(path);
    http.Response response = await http.get(_uri);
    if(response.statusCode == 200){
      Map<String, dynamic> myMap = json.decode(response.body);
      List images = myMap["backdrops"];
      List<ImageModel> imageModelList = images.map((e) => ImageModel.fromJson(e)).toList();
      print(imageModelList);
      return imageModelList;
    }
    return [];
  }
}
