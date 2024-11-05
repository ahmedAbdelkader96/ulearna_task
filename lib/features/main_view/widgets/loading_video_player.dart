import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task/global/widgets/cache_video_image.dart';

class LoadingVideoPlayer extends StatefulWidget {
  const LoadingVideoPlayer({super.key, required this.thumbUrl});

  final String thumbUrl;

  @override
  State<LoadingVideoPlayer> createState() => _LoadingVideoPlayerState();
}

class _LoadingVideoPlayerState extends State<LoadingVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return widget.thumbUrl.isNotEmpty
        ? CacheVideoImage(thumbUrl: widget.thumbUrl)
        : AspectRatio(
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
          );
  }
}
