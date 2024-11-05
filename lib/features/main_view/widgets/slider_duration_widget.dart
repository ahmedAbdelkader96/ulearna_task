import 'package:flutter/material.dart';
import 'package:task/features/main_view/models/video_model.dart';
import 'package:task/features/main_view/widgets/mute_unmute_animated_button.dart';
import 'package:task/global/methods_helpers_functions/media_query.dart';
import 'package:task/global/methods_helpers_functions/video_helper.dart';
import 'package:video_player/video_player.dart';

class SliderDurationWidget extends StatefulWidget {
  const SliderDurationWidget(
      {super.key,
      required this.videoPlayerController,
      required this.videoModel});

  final VideoPlayerController videoPlayerController;
  final VideoModel videoModel;

  @override
  State<SliderDurationWidget> createState() => _SliderDurationWidgetState();
}

class _SliderDurationWidgetState extends State<SliderDurationWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: MQuery.currentWidth(context),
          padding:
              EdgeInsets.symmetric(horizontal: MQuery.getheight(context, 16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${VideoHelper.formatDuration(widget.videoPlayerController.value.position)} / ${VideoHelper.formatDuration(widget.videoPlayerController.value.duration == Duration.zero ? Duration(seconds: widget.videoModel.duration) : widget.videoPlayerController.value.duration)}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              MuteUnmuteAnimatedButton(
                  videoPlayerController: widget.videoPlayerController)
            ],
          ),
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
              value: widget.videoPlayerController.value.position.inSeconds
                  .toDouble(),
              min: 0.0,
              max: widget.videoPlayerController.value.duration.inSeconds
                  .toDouble(),
              onChanged: (value) {
                setState(() {
                  //isControlDone = true;
                  widget.videoPlayerController
                      .seekTo(Duration(seconds: value.toInt()));
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
