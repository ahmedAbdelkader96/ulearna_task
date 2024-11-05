import 'package:flutter/material.dart';
import 'package:task/features/main_view/widgets/rewind_animated_button.dart';
import 'package:task/global/widgets/general_circular_raw_material_button.dart';

class ControlsButton extends StatefulWidget {
  const ControlsButton(
      {super.key,
      required this.controlPlayPauseButtonController,
      required this.onPressedToPlayPause,
      required this.isControlsShown,
      required this.onRewind10SecBack,
      required this.onRewind10SecForward});

  final AnimationController controlPlayPauseButtonController;
  final void Function() onPressedToPlayPause;
  final void Function() onRewind10SecBack;
  final void Function() onRewind10SecForward;
  final bool isControlsShown;

  @override
  State<ControlsButton> createState() => _ControlsButtonState();
}

class _ControlsButtonState extends State<ControlsButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 150,
      child: Center(
        child: AnimatedOpacity(
          opacity: widget.isControlsShown ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            alignment: AlignmentDirectional.center,
            height: widget.isControlsShown == true ? 55 : 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSlide(
                      offset: widget.isControlsShown == true
                          ? const Offset(0, 0)
                          : const Offset(0, -0.5),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.ease,
                      child: RewindAnimatedButton(
                          imagePath: "assets/images/rewind-seconds-back.svg",
                          onPressed: () {
                            widget.onRewind10SecBack();
                          })),
                  const SizedBox(width: 15),
                  AnimatedSlide(
                      offset: widget.isControlsShown == true
                          ? const Offset(0, 0)
                          : const Offset(0, 0.5),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.ease,
                      child: GeneralCircularRawMaterialButton(
                          onPressed: widget.onPressedToPlayPause,
                          height: 55,
                          width: 55,
                          backColor: Colors.black45,
                          borderSideWidth: 0,
                          borderSideColor: Colors.transparent,
                          child: AnimatedIcon(
                            icon: AnimatedIcons.pause_play,
                            progress: widget.controlPlayPauseButtonController,
                            size: 40,
                            color: Colors.white,
                          ))),
                  const SizedBox(width: 10),
                  AnimatedSlide(
                      offset: widget.isControlsShown == true
                          ? const Offset(0, 0)
                          : const Offset(0, -0.5),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.ease,
                      child: RewindAnimatedButton(
                          imagePath: "assets/images/rewind-seconds-forward.svg",
                          onPressed: () {
                            widget.onRewind10SecForward();
                          }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
