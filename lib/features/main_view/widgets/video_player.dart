import 'package:flutter/material.dart';
import 'package:task/features/main_view/models/video_model.dart';
import 'package:task/global/methods_helpers_functions/video_helper.dart';
import 'package:task/global/widgets/cache_video_image.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget(
      {super.key,
      required this.videoPlayerController,
      required this.videoModel});

  final VideoPlayerController videoPlayerController;

  final VideoModel videoModel;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: VideoHelper.aspectRatioFromString(
                  widget.videoModel.aspectRatio),
              child: VideoPlayer(widget.videoPlayerController),
            )
          : CacheVideoImage(
              thumbUrl:
                  widget.videoModel.thumbUrl), // Show thumbnail while loading
    );
  }
}
