import 'package:flutter/material.dart';
import 'package:task/features/main_view/models/video_model.dart';
import 'package:task/features/main_view/widgets/animated_play_pause_button.dart';
import 'package:task/features/main_view/widgets/comments_shares_likes_widget.dart';
import 'package:task/features/main_view/widgets/slider_duration_widget.dart';
import 'package:task/features/main_view/widgets/user_details_and_follow_button_widget.dart';
import 'package:task/features/main_view/widgets/video_player.dart';
import 'package:task/global/methods_helpers_functions/media_query.dart';
import 'package:task/global/navigation_routes/routes.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  const VideoItem(
      {super.key,
      required this.videoPlayerController,
      required this.videoModel,
      required this.controllers});

  final VideoPlayerController videoPlayerController;

  final List<VideoPlayerController?> controllers;

  final VideoModel videoModel;

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem>
    with SingleTickerProviderStateMixin {
  late AnimationController controlPlayPauseButtonController;

  bool isLikeClicked = false;
  bool isControlsShown = false;

  @override
  void initState() {
    super.initState();
    playVideoController();

    controlPlayPauseButtonController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    Future.delayed(const Duration(milliseconds: 1), () {
      setState(() {
        isControlsShown = true;
      });
    });
  }

  playVideoController() {
    try {
      widget.videoPlayerController.play();
      widget.videoPlayerController.addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    controlPlayPauseButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        if (!widget.videoPlayerController.value.hasError)
          VideoPlayerWidget(
              videoPlayerController: widget.videoPlayerController,
              videoModel: widget.videoModel),
        if (widget.videoPlayerController.value.hasError)
          const Center(
              child: Text(
                  "Playback Error : This video format is not supported. Please try another video.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white))),

        GestureDetector(
          onTap: () {
            setState(() {
              isControlsShown = !isControlsShown;
            });
          },
          child: Container(
            height: MQuery.currentHeight(context),
            width: MQuery.currentWidth(context),
            color: Colors.transparent,
          ),
        ),
        Center(
          child: ControlsButton(
              controlPlayPauseButtonController:
                  controlPlayPauseButtonController,
              onPressedToPlayPause: () {
                if (widget.videoPlayerController.value.isPlaying) {
                  widget.videoPlayerController.pause();
                  controlPlayPauseButtonController.forward();
                  setState(() {});
                } else {
                  widget.videoPlayerController.play();
                  controlPlayPauseButtonController.reverse();

                  setState(() {});
                }
              },
              onRewind10SecBack: () {
                final currentPosition =
                    widget.videoPlayerController.value.position;
                final newPosition =
                    currentPosition - const Duration(seconds: 10);
                if (newPosition < Duration.zero) {
                  widget.videoPlayerController.seekTo(Duration.zero);
                  setState(() {});
                } else {
                  widget.videoPlayerController.seekTo(newPosition);
                  setState(() {});
                }
                setState(() {});
              },
              onRewind10SecForward: () {
                final currentPosition =
                    widget.videoPlayerController.value.position;
                final newPosition =
                    currentPosition + const Duration(seconds: 10);
                if (newPosition < Duration.zero) {
                  widget.videoPlayerController.seekTo(Duration.zero);
                  setState(() {});
                } else {
                  widget.videoPlayerController.seekTo(newPosition);
                  setState(() {});
                }
              },
              isControlsShown: isControlsShown),
        ),
        Positioned(
          bottom: MQuery.getheight(context, 100),
          right: MQuery.getWidth(context, 16),
          child: CommentsSharesLikesWidget(videoModel: widget.videoModel),
        ),
        Positioned(
          bottom: 60,
          left: MQuery.getWidth(context, 16),
          right: 0,
          child: UserDetailsAndFollowButtonWidget(
              videoModel: widget.videoModel,
              onPressedUserImageToNavigate: () {
                setState(() {
                  controlPlayPauseButtonController.forward();
                  isControlsShown = true;
                });

                widget.videoPlayerController.pause();

                Routes.userProfileScreen(
                    context: context, userModel: widget.videoModel.userModel);
              }),
        ),
        Positioned(
          bottom: 0,
          child: SliderDurationWidget(
              videoPlayerController: widget.videoPlayerController,
              videoModel: widget.videoModel),
        )
      ],
    );
  }
}
