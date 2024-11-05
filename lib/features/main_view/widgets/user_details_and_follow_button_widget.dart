import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task/features/main_view/models/video_model.dart';
import 'package:task/features/main_view/widgets/follow_animated_button.dart';

class UserDetailsAndFollowButtonWidget extends StatelessWidget {
  const UserDetailsAndFollowButtonWidget(
      {super.key,
      required this.videoModel,
      required this.onPressedUserImageToNavigate});

  final VideoModel videoModel;
  final Function() onPressedUserImageToNavigate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: onPressedUserImageToNavigate,
              child: ClipOval(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: videoModel.userModel.profilePictureUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: videoModel.userModel.profilePictureUrl,
                          fit: BoxFit.cover,
                          errorWidget: (BuildContext context, str, obj) {
                            return Container(
                              color: Colors.white,
                              child: const Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                            );
                          },
                        )
                      : Container(
                          color: Colors.white,
                          child: const Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              videoModel.userModel.userName,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            const FollowAnimatedButton(),
          ],
        ),
        if (videoModel.userModel.designation.isNotEmpty)
          const SizedBox(height: 8),
        if (videoModel.userModel.designation.isNotEmpty)
          Text(
            videoModel.userModel.designation,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
      ],
    );
  }
}
