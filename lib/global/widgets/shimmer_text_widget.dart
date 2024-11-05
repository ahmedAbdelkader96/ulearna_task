import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTextWidget extends StatelessWidget {
  const ShimmerTextWidget({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey.withOpacity(0.4),
        ),
        child: const Text(
          "",
          style: TextStyle(
            fontSize: 14,
            color: Colors.transparent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
