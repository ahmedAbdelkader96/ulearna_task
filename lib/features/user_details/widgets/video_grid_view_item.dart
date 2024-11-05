import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:task/features/main_view/models/video_model.dart';
import 'package:task/features/user_details/widgets/loading_video_thumb_widget.dart';
import 'package:task/global/navigation_routes/routes.dart';

class VideoGridViewItem extends StatefulWidget {
  const VideoGridViewItem(
      {super.key,
      required this.thumbUrl,
      required this.videos,
      required this.pageIndex});

  final String thumbUrl;
  final List<VideoModel> videos;
  final int pageIndex;

  @override
  State<VideoGridViewItem> createState() => _VideoGridViewItemState();
}

class _VideoGridViewItemState extends State<VideoGridViewItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    if (widget.thumbUrl.isEmpty) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade200),
        child: const Icon(Icons.error_outline, color: Colors.black, size: 25),
      );
    }

    return InkWell(
      radius: 8,
      onTap: () async {
        if (!isSelected) {
          setState(() {
            isSelected = true;
          });
          await Future.delayed(const Duration(milliseconds: 180), () {
            setState(() {
              isSelected = false;
            });
          });
        }

        Future.delayed(const Duration(milliseconds: 200), () {
          SchedulerBinding.instance.addPostFrameCallback((e) {
            Routes.userVideosScreen(
                context: context,
                videos: widget.videos,
                pageIndex: widget.pageIndex);
          });
        });
      },
      child: AnimatedScale(
        scale: isSelected ? 0.95 : 1,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            alignment: AlignmentDirectional.center,
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: widget.thumbUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: LoadingVideoThumbWidget(),
                ),
                errorWidget: (BuildContext context, str, obj) {
                  return Container(
                    color: Colors.white,
                    child: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  );
                },
              ),
              Center(
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black54),
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
