import 'package:flutter/material.dart';
import 'package:task/features/main_view/models/video_model.dart';
import 'package:task/features/main_view/widgets/action_animated_button.dart';

class CommentsSharesLikesWidget extends StatelessWidget {
  const CommentsSharesLikesWidget({super.key, required this.videoModel});

  final VideoModel videoModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ActionAnimatedButton(
          firstWidget: const Icon(
            Icons.favorite,
            size: 32,
            color: Colors.red,
          ),
          secondWidget: Icon(
            Icons.favorite,
            size: 32,
            color: Colors.grey[300],
          ),
        ),
        Text(
          '${videoModel.totalLikes}',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        const ActionAnimatedButton(
            firstWidget: Icon(
              Icons.comment,
              color: Colors.white,
              size: 28,
            ),
            secondWidget: Icon(
              Icons.comment,
              color: Colors.white,
              size: 28,
            )),
        Text(
          '${videoModel.totalComments}',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        const ActionAnimatedButton(
            firstWidget: Icon(
              Icons.send,
              color: Colors.white,
              size: 28,
            ),
            secondWidget: Icon(
              Icons.send,
              color: Colors.white,
              size: 28,
            )),
        Text(
          '${videoModel.totalShare}',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
