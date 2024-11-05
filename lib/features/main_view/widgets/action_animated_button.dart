import 'package:flutter/material.dart';

class ActionAnimatedButton extends StatefulWidget {
  const ActionAnimatedButton(
      {super.key, required this.firstWidget, required this.secondWidget});

  final Widget firstWidget;
  final Widget secondWidget;

  @override
  State<ActionAnimatedButton> createState() => _ActionAnimatedButtonState();
}

class _ActionAnimatedButtonState extends State<ActionAnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  bool isClikced = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isClikced = !isClikced;
        });
        controller.reverse().then((value) => controller.forward());
      },
      child: SizedBox(
        height: 40,
        width: 40,
        child: ScaleTransition(
          scale: Tween(begin: 0.7, end: 1.0).animate(
              CurvedAnimation(parent: controller, curve: Curves.easeOut)),
          child: Center(
              child: isClikced ? widget.firstWidget : widget.secondWidget),
        ),
      ),
    );
  }
}
