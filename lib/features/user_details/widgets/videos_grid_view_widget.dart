import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:task/features/main_view/models/video_model.dart';
import 'package:task/features/user_details/widgets/video_grid_view_item.dart';
import 'package:task/global/methods_helpers_functions/media_query.dart';

class VideosGridViewWidget extends StatefulWidget {
  const VideosGridViewWidget({super.key, required this.videos});

  final List<VideoModel> videos;

  @override
  State<VideosGridViewWidget> createState() => _VideosGridViewWidgetState();
}

class _VideosGridViewWidgetState extends State<VideosGridViewWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: MQuery.getWidth(context, 16)),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: widget.videos.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 500),
            columnCount: 3,
            child: ScaleAnimation(
              duration: const Duration(milliseconds: 900),
              curve: Curves.fastLinearToSlowEaseIn,
              child: FadeInAnimation(
                child: VideoGridViewItem(
                  thumbUrl: widget.videos[index].thumbUrl,
                  videos: widget.videos,
                  pageIndex: index,
                ),
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100, crossAxisSpacing: 10, mainAxisSpacing: 10),
      ),
    );
  }
}
