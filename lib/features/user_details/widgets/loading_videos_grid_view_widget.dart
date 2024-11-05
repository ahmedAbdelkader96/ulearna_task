import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:task/features/user_details/widgets/loading_video_thumb_widget.dart';
import 'package:task/global/methods_helpers_functions/media_query.dart';

class LoadingVideosGridViewWidget extends StatelessWidget {
  const LoadingVideosGridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: MQuery.getWidth(context, 16)),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: 20,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 500),
            columnCount: 3,
            child: const ScaleAnimation(
              duration: Duration(milliseconds: 900),
              curve: Curves.fastLinearToSlowEaseIn,
              child: FadeInAnimation(
                child: LoadingVideoThumbWidget(),
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
