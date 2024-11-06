import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CacheVideoImage extends StatelessWidget {
  const CacheVideoImage({super.key, required this.thumbUrl});

  final String thumbUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: thumbUrl,
      fit: BoxFit.cover,
      errorWidget: (BuildContext context, str, obj) {
        return Container(
          color: Colors.transparent,
          child: const Center(
            child: Text(
              "No Thumb Url",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
      placeholder: (c, s) {
        return Center(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
