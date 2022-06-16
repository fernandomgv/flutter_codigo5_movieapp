

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_codigo5_movieapp/ui/widgets/progress_indicator_widget.dart';

import '../../model/person_model.dart';
import '../../services/api_service.dart';
import '../general/colors.dart';

class CastDetailWidget extends StatefulWidget {


  int Id;
  CastDetailWidget({ required this.Id});
  @override
  State<CastDetailWidget> createState() => _CastDetailWidgetState();
}

class _CastDetailWidgetState extends State<CastDetailWidget> {

  final APIService _service = APIService();
  bool isLoading = true;
  PersonModel? personModel;
  getData() async
  {
    personModel = await this._service.getDataPerson(widget.Id);
    isLoading = false;
    setState(() {
    });
  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return
      AlertDialog(
        backgroundColor: kBrandPrimaryColor ,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      contentPadding: EdgeInsets.zero,
      content: isLoading ?
      const SizedBox(
        height: 300,
        child: ProgressIndicatorWidget(),
      )
      :
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20) ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  personModel!.profilePath != "" ?
                  "https://image.tmdb.org/t/p/w500${personModel!.profilePath}"
                  : personModel!.gender == 2 ? "https://cdn4.vectorstock.com/i/thumb-large/46/78/person-gray-photo-placeholder-girl-material-design-vector-23804678.jpg"
                      : "https://www.revixpert.ch/app/uploads/portrait-placeholder.jpg"
                  ,),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                Text(
                  personModel!.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  personModel!.placeOfBirth,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 13.0,
                  ),
                ),
                Text(
                  personModel!.birthday.toString().substring(0,10),
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}
