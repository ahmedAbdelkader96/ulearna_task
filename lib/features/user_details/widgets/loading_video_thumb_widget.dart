import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingVideoThumbWidget extends StatelessWidget {
  const LoadingVideoThumbWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        //width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
    );
  }
}
