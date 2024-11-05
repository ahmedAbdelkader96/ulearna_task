import 'package:flutter/material.dart';
import 'package:task/features/user_details/widgets/loading_comments_views_shares_item.dart';

class LoadingCommentsViewsShareWidget extends StatelessWidget {
  const LoadingCommentsViewsShareWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        LoadingCommentsViewsSharesItem(icon: Icons.ondemand_video_rounded),
        LoadingCommentsViewsSharesItem(icon: Icons.favorite),
        LoadingCommentsViewsSharesItem(icon: Icons.comment),
        LoadingCommentsViewsSharesItem(icon: Icons.send),
        LoadingCommentsViewsSharesItem(icon: Icons.visibility),
      ],
    );
  }
}
