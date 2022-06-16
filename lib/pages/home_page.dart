
import 'dart:convert';
//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_movieapp/model/genres_model.dart';
import 'package:flutter_codigo5_movieapp/model/movie_model.dart';
import 'package:flutter_codigo5_movieapp/services/api_service.dart';
import 'package:flutter_codigo5_movieapp/ui/widgets/item_filter_widget.dart';
import 'package:flutter_codigo5_movieapp/ui/widgets/item_movie_widget.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  //List movieList =[];
  final APIService _service = APIService();
  List<MovieModel> movieModelList = [];
  List<GenresModel> genresModelList = [];
  String withGenres="";
  List<int> withGenresList = [];
  getDataGenres() {
    _service.getDataGenres().then(( List<GenresModel> value) {
      genresModelList =   value;
      print(value.length);
      //value.forEach((e) { print(e.name); });
      genresModelList.forEach((e) { print(e.name); });
      setState(() {});
      genresModelList.insert(0, GenresModel(id: 0, name: "All",isSelected: true) );
    });

  }
  getDataMovies(){
    _service.getDataMovies().then(( List<MovieModel> value)  {
      movieModelList =   value;
      print(value.length);
      //value.forEach((e) { print(e.title); });
      movieModelList.forEach((e) { print(e.title); });
      setState(() {});
    });

  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    getDataMovies();
    getDataGenres();
  }

  List<Widget> getFilters()
  {
    List<Widget> filters = [];


      filters.add(ItemFilterWidget(filter: GenresModel(id: 0, name: "All") ,isSelected: true,withGenresList: withGenresList,));
      genresModelList.forEach((genres) {
        filters.add(ItemFilterWidget(filter: genres,withGenresList: withGenresList,));
      });
      print("generando  ${filters.length} filtros");


    setState(() {});
    return filters;

  }
  /*
  filterMovie(){
    
    if (movieModelList.isNotEmpty)
      {
        if(withGenresList.isNotEmpty)
          {
            movieModelList.where((element) => element.genreIds.contains(20)).toList();
          }
        
      }
    
  }*/

  @override
  Widget build(BuildContext context) {

    print(withGenresList);
    return Scaffold(
      backgroundColor: Color(0xff161823),
      body: SafeArea(
        child: SingleChildScrollView(

          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Discover",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(3.5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.redAccent,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xff5de09c),
                            Color(0xff23dec3),
                          ],
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.asset("assets/images/fmogollon.jpg",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                   //children: getFilters(),
                    // ItemFilterWidget(filter: GenresModel(id: 0, name: "All") ,isSelected: true,withGenresList: withGenresList,)
                   children:genresModelList.map( (e) => ItemFilterWidget(filter: e,isSelected: e.isSelected,withGenresList: withGenresList,)).toList(),

                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: movieModelList.length,
                  itemBuilder: (BuildContext context, int index) {
                    
                    return ItemMovieWidget(movie: movieModelList[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
