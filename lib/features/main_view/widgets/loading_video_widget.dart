import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task/features/main_view/models/video_model.dart';
import 'package:task/features/main_view/widgets/action_animated_button.dart';
import 'package:task/features/main_view/widgets/comments_shares_likes_widget.dart';
import 'package:task/features/main_view/widgets/loading_video_player.dart';
import 'package:task/features/main_view/widgets/rewind_animated_button.dart';
import 'package:task/features/main_view/widgets/user_details_and_follow_button_widget.dart';
import 'package:task/global/methods_helpers_functions/media_query.dart';
import 'package:task/global/methods_helpers_functions/video_helper.dart';
import 'package:task/global/widgets/general_circular_raw_material_button.dart';
import 'package:task/global/widgets/shimmer_text_widget.dart';

class LoadingVideoWidget extends StatefulWidget {
  const LoadingVideoWidget({super.key, required this.video});

  final VideoModel? video;

  @override
  State<LoadingVideoWidget> createState() => _LoadingVideoWidgetState();
}

class _LoadingVideoWidgetState extends State<LoadingVideoWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        LoadingVideoPlayer(
            thumbUrl: widget.video != null ? widget.video!.thumbUrl : ""),
        Center(
          child: SizedBox(
            height: 100,
            width: 150,
            child: Center(
              child: AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 500),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  alignment: AlignmentDirectional.center,
                  height: 55,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RewindAnimatedButton(
                            imagePath: "assets/images/rewind-seconds-back.svg",
                            onPressed: () {}),
                        const SizedBox(width: 15),
                        GeneralCircularRawMaterialButton(
                            onPressed: () {},
                            height: 55,
                            width: 55,
                            backColor: Colors.black45,
                            borderSideWidth: 0,
                            borderSideColor: Colors.transparent,
                            child: const Icon(
                              Icons.play_arrow,
                              size: 40,
                              color: Colors.white,
                            )),
                        const SizedBox(width: 10),
                        RewindAnimatedButton(
                            imagePath:
                                "assets/images/rewind-seconds-forward.svg",
                            onPressed: () {}),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: MQuery.getheight(context, 100),
          right: MQuery.getWidth(context, 16),
          child: widget.video != null
              ? CommentsSharesLikesWidget(videoModel: widget.video!)
              : Column(
                  children: [
                    ActionAnimatedButton(
                      firstWidget: const Icon(
                        Icons.favorite,
                        size: 32,
                        color: Colors.red,
                      ),
                      secondWidget: Icon(
                        Icons.favorite,
                        size: 32,
                        color: Colors.grey[300],
                      ),
                    ),
                    const ShimmerTextWidget(width: 40),
                    const SizedBox(height: 10),
                    const ActionAnimatedButton(
                        firstWidget: Icon(
                          Icons.comment,
                          color: Colors.white,
                          size: 28,
                        ),
                        secondWidget: Icon(
                          Icons.comment,
                          color: Colors.white,
                          size: 28,
                        )),
                    const ShimmerTextWidget(width: 40),
                    const SizedBox(height: 10),
                    const ActionAnimatedButton(
                        firstWidget: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 28,
                        ),
                        secondWidget: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 28,
                        )),
                    const ShimmerTextWidget(width: 40),
                  ],
                ),
        ),
        Positioned(
          bottom: 60,
          left: MQuery.getWidth(context, 16),
          right: 0,
          child: widget.video != null
              ? UserDetailsAndFollowButtonWidget(
                  videoModel: widget.video!,
                  onPressedUserImageToNavigate: () {})
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey,
                            highlightColor: Colors.white,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.grey.withOpacity(0.4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const ShimmerTextWidget(width: 130),
                        const SizedBox(width: 10),
                        const ShimmerTextWidget(width: 80),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const ShimmerTextWidget(width: 110)
                  ],
                ),
        ),
        Positioned(
          bottom: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MQuery.getheight(context, 16)),
                child: widget.video != null
                    ? Row(
                        children: [
                          Text(
                            '00:00:00 / ${VideoHelper.formatDuration(Duration(seconds: widget.video!.duration))}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    : const ShimmerTextWidget(width: 80),
              ),
              SizedBox(
                width: MQuery.currentWidth(context),
                height: 20,
                child: SliderTheme(
                  data: const SliderThemeData(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
                  ),
                  child: Slider(
                    //secondaryTrackValue: 1,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white38,
                    value: 0,
                    // min: 0.0,
                    //max: widget.video != null? widget.video.duration.toDouble() : 0,
                    onChanged: (value) {},
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
