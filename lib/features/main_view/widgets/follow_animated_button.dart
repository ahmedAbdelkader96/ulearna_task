import 'package:flutter/material.dart';

class FollowAnimatedButton extends StatefulWidget {
  const FollowAnimatedButton({super.key});

  @override
  State<FollowAnimatedButton> createState() => _FollowAnimatedButtonState();
}

class _FollowAnimatedButtonState extends State<FollowAnimatedButton>
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
      child: ScaleTransition(
        scale: Tween(begin: 0.9, end: 1.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeOut)),
        child: Container(
          height: 25,
          width: 80,
          decoration: BoxDecoration(
            color: isClikced ? Colors.white38 : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.white),
          ),
          child: Center(
              child: isClikced
                  ? const Text(
                      'Following',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Follow',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    )),
        ),
      ),
    );
  }
}
