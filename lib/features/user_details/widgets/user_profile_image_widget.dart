import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task/global/widgets/shimmer_widget.dart';

class UserProfileImageWidget extends StatefulWidget {
  const UserProfileImageWidget({super.key, required this.profilePictureUrl});

  final String profilePictureUrl;

  @override
  State<UserProfileImageWidget> createState() => _UserProfileImageWidgetState();
}

class _UserProfileImageWidgetState extends State<UserProfileImageWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;

  late final AnimationController controller = AnimationController(
      duration: const Duration(seconds: 7), vsync: this, value: 1.0);

  @override
  void initState() {
    super.initState();

    animation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );

    controller.repeat();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          RotationTransition(
            turns: animation.drive(Tween<double>(begin: 0, end: 1)),
            child: Container(
              height: 115,
              width: 115,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.red.withOpacity(0.8),

                      Colors.purple,
                      Colors.blueAccent,

                      Colors.blueGrey,
                      //Colors.white,
                    ],
                  )),
            ),
          ),
          Container(
            height: 105,
            width: 105,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 5, color: Colors.white)),
            child: ClipOval(
              //borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: widget.profilePictureUrl,
                fit: BoxFit.cover,
                height: 100,
                width: 100,
                errorWidget: (BuildContext context, str, obj) {
                  return Container(
                    color: Colors.white,
                    child: const Center(
                        child: Icon(
                      Icons.error_outline,
                      color: Colors.black,
                    )),
                  );
                },
                placeholder: (context, str) {
                  return const LoadingShimmerWidget(height: 100, width: 100);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
