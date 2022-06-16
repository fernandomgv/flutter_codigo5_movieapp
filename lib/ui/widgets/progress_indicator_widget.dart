

import 'package:flutter/material.dart';

import '../general/colors.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 26,
        width: 26,
        child: CircularProgressIndicator(
          color: kBrandSecondaryColor,
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}
