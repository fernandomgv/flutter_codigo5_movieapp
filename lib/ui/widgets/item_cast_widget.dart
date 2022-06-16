
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_movieapp/model/cast_model.dart';

class ItemCastWidget extends StatelessWidget {
  //const ItemCastWidget({Key? key}) : super(key: key);

  CastModel castModel;

  ItemCastWidget({
    required this.castModel
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white38,
            radius: 38,
            backgroundImage: NetworkImage(
              castModel.profilePath !="" ?
              "http://image.tmdb.org/t/p/w500${castModel.profilePath}"
              : castModel.gender == 2 ? "https://cdn4.vectorstock.com/i/thumb-large/46/78/person-gray-photo-placeholder-girl-material-design-vector-23804678.jpg"
                : "https://www.revixpert.ch/app/uploads/portrait-placeholder.jpg"
              ,
            ),
          ),
          const SizedBox(
            height: 3.0,
          ),
          Text(
            castModel.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          Text(
            castModel.character,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}