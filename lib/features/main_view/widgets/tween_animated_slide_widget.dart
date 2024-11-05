import 'package:flutter/material.dart';

class TweenAnimatedSlideWidget extends StatefulWidget {
  const TweenAnimatedSlideWidget({
    super.key,
    required this.beginOffset,
    required this.endOffset,
    required this.duration,
    required this.widget,
    required this.curve,
  });

  final Offset beginOffset;
  final Offset endOffset;
  final Duration duration;
  final Widget widget;
  final Curve curve;

  @override
  State<TweenAnimatedSlideWidget> createState() =>
      _TweenAnimatedSlideWidgetState();
}

class _TweenAnimatedSlideWidgetState extends State<TweenAnimatedSlideWidget> {
  bool isWillAnimate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 1), () {
      setState(() {
        isWillAnimate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: isWillAnimate ? widget.endOffset : widget.beginOffset,
      duration: widget.duration,
      curve: widget.curve,
      child: widget.widget,
    );
  }
}
