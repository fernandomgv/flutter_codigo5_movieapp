import 'package:flutter/material.dart';
import 'package:flutter_codigo5_movieapp/model/reviews_model.dart';

class ItemReviewWidget extends StatelessWidget {
  //const ItemReviewWidget({Key? key}) : super(key: key);

  ReviewsModel reviewsModel;

  ItemReviewWidget({
    required this.reviewsModel,
  });


  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      textColor: Colors.white,
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(reviewsModel.author,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          )),
      subtitle: Row(
        children: [
          Text(
            "${reviewsModel.createdAt.toString().substring(0, 10)}",
            style: TextStyle(color: Colors.white54, fontSize: 13.0),
          ),
          const SizedBox(
            width: 12.0,
          ),
          Icon(
            Icons.star,
            color: Colors.white54,
            size: 14.0,
          ),
          Text(
            "${reviewsModel.authorDetails.rating.toString()}",
            style: TextStyle(color: Colors.white54, fontSize: 13.0),
          ),
        ],
      ),
      children: [
        Text(
          reviewsModel.content,
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
