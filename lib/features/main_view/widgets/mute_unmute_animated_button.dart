import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MuteUnmuteAnimatedButton extends StatefulWidget {
  const MuteUnmuteAnimatedButton(
      {super.key, required this.videoPlayerController});

  final VideoPlayerController videoPlayerController;

  @override
  State<MuteUnmuteAnimatedButton> createState() =>
      _MuteUnmuteAnimatedButtonState();
}

class _MuteUnmuteAnimatedButtonState extends State<MuteUnmuteAnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
      duration: const Duration(milliseconds: 400), vsync: this, value: 1.0);

  late Animation<double> animation;
  bool isMuted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animation = Tween<double>(begin: 0.3, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggleMute() {
    setState(() {
      if (isMuted) {
        controller.reverse().then((value) => controller.forward());
        widget.videoPlayerController.setVolume(1);
        toggleMuteParam(false);
      } else {
        controller.reverse().then((value) => controller.forward());
        widget.videoPlayerController.setVolume(0);
        toggleMuteParam(true);
      }
    });
  }

  void toggleMuteParam(bool value) {
    Future.delayed(const Duration(milliseconds: 150), () {
      isMuted = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      color: Colors.transparent,
      child: GestureDetector(
        onTap: toggleMute,
        child: RotationTransition(
          turns: animation.drive(Tween<double>(begin: 0, end: -0.3)),
          child: Container(
            height: 35,
            width: 35,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.black45),
            child: Center(
                child: Icon(isMuted ? Icons.volume_off : Icons.volume_up,
                    color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
