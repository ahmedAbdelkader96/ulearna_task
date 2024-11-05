import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/features/main_view/models/user_model.dart';
import 'package:task/features/main_view/models/video_model.dart';
import 'package:task/features/user_details/bloc/fetch_user_videos_bloc.dart';
import 'package:task/features/user_details/widgets/loading_videos_grid_view_widget.dart';
import 'package:task/features/user_details/widgets/user_details_widget.dart';
import 'package:task/features/user_details/widgets/videos_grid_view_widget.dart';
import 'package:task/global/methods_helpers_functions/local_storage.dart';
import 'package:task/global/methods_helpers_functions/media_query.dart';
import 'package:task/global/widgets/general_circular_raw_material_button.dart';
import 'package:video_player/video_player.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<VideoModel> videos = [];
  List<VideoPlayerController?> videoPlayerControllers = [];

  @override
  void initState() {
    initPage();
    // TODO: implement initState
    super.initState();
  }

  UserVideosDatabaseHelper userVideosDatabaseHelper =
      UserVideosDatabaseHelper();

  initPage() async {
    List<VideoModel> vids = await userVideosDatabaseHelper.getAllVideos();
    if (vids.isNotEmpty) {
      if (vids[0].userId != widget.userModel.userId) {
        await userVideosDatabaseHelper.deleteAllVideos();
        context
            .read<FetchUserVideosBloc>()
            .add(FetchUserVideos(userId: widget.userModel.userId));
      } else {
        setState(() {
          videos = vids;
        });
      }
    } else {
      context
          .read<FetchUserVideosBloc>()
          .add(FetchUserVideos(userId: widget.userModel.userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MQuery.getheight(context, 45),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: MQuery.getWidth(context, 5)),
            child: Row(
              children: [
                GeneralCircularRawMaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    height: 40,
                    width: 40,
                    backColor: Colors.transparent,
                    borderSideWidth: 0,
                    borderSideColor: Colors.transparent,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 3),
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 17,
                        color: Colors.black,
                      ),
                    )),
                Expanded(
                    child: Center(
                        child: Text(
                  '@${widget.userModel.userName}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ))),
                const SizedBox(
                  width: 40,
                )
              ],
            ),
          ),
          UserDetailsWidget(userModel: widget.userModel, videos: videos),
          const Divider(
            thickness: 0.5,
            endIndent: 0,
            indent: 0,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Center(
              child: BlocConsumer<FetchUserVideosBloc, FetchUserVideosState>(
                listener: (context, state) async {
                  if (state is ErrorToFetchUserVideosState) {
                    debugPrint(state.message);
                  }

                  if (state is DoneToFetchUserVideosState) {
                    await userVideosDatabaseHelper
                        .insertManyVideosToTable(state.videos);
                    setState(() {
                      videos.addAll(state.videos);
                    });
                  }
                },
                builder: (context, state) {
                  if (videos.isNotEmpty) {
                    return VideosGridViewWidget(videos: videos);
                  }

                  if (state is ErrorToFetchUserVideosState) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return const LoadingVideosGridViewWidget();

                  //return LoadingUserVideosWidget();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
