import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RewindAnimatedButton extends StatefulWidget {
  const RewindAnimatedButton(
      {super.key, required this.imagePath, required this.onPressed});

  final String imagePath;
  final Function() onPressed;

  @override
  State<RewindAnimatedButton> createState() => _RewindAnimatedButtonState();
}

class _RewindAnimatedButtonState extends State<RewindAnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.reverse().then((value) => controller.forward());
        widget.onPressed();
      },
      child: ScaleTransition(
        scale: Tween(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeOut)),
        child: Container(
          height: 35,
          width: 35,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Colors.black45),
          child: Center(
              child: SvgPicture.asset(
            widget.imagePath,
            height: 20,
            width: 20,
            color: Colors.white,
          )),
        ),
      ),
    );
  }
}
