import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/features/main_view/models/user_model.dart';
import 'package:task/features/main_view/models/video_model.dart';
import 'package:task/features/user_details/bloc/fetch_user_videos_bloc.dart';
import 'package:task/features/user_details/widgets/loading_comments_views_share_widget.dart';
import 'package:task/features/user_details/widgets/total_widget.dart';
import 'package:task/features/user_details/widgets/user_profile_image_widget.dart';
import 'package:task/global/methods_helpers_functions/media_query.dart';

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget(
      {super.key, required this.userModel, required this.videos});

  final UserModel userModel;
  final List<VideoModel> videos;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: MQuery.currentWidth(context),
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: MQuery.getWidth(context, 16)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UserProfileImageWidget(
                  profilePictureUrl: userModel.profilePictureUrl),
              SizedBox(width: MQuery.getWidth(context, 12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userModel.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    Text(
                      userModel.userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  userModel.designation,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          BlocBuilder<FetchUserVideosBloc, FetchUserVideosState>(
            builder: (context, state) {
              if (videos.isNotEmpty) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TotalWidget(
                        sum: videos.length.toString(),
                        icon: Icons.ondemand_video_rounded),
                    TotalWidget(
                        sum: videos
                            .fold(0, (sum, video) => sum + video.totalLikes)
                            .toString(),
                        icon: Icons.favorite),
                    TotalWidget(
                        sum: videos
                            .fold(0, (sum, video) => sum + video.totalComments)
                            .toString(),
                        icon: Icons.comment),
                    TotalWidget(
                        sum: videos
                            .fold(0, (sum, video) => sum + video.totalShare)
                            .toString(),
                        icon: Icons.send),
                    TotalWidget(
                        sum: videos
                            .fold(0, (sum, video) => sum + video.totalViews)
                            .toString(),
                        icon: Icons.visibility),
                  ],
                );
              }

              return const LoadingCommentsViewsShareWidget();

              //return LoadingUserVideosWidget();
            },
          ),
        ],
      ),
    );
  }
}
