import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:task/features/main_view/bloc/fetch_videos_bloc.dart';
import 'package:task/features/main_view/models/video_model.dart';
import 'package:task/global/methods_helpers_functions/local_storage.dart';
import 'package:task/global/methods_helpers_functions/media_query.dart';
import 'package:task/global/methods_helpers_functions/toast.dart';
import 'package:task/global/navigation_routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  VideoDatabaseHelper videoDatabaseHelper = VideoDatabaseHelper();
  UserVideosDatabaseHelper userVideosDatabaseHelper =
      UserVideosDatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    await videoDatabaseHelper.initializeDatabase();
    await userVideosDatabaseHelper.initializeDatabase();

    List<VideoModel> videos = await videoDatabaseHelper.getAllVideos();
    if (mounted) {
      if (videos.isNotEmpty && mounted) {
        Routes.mainScreen(context: context, videos: videos);
      } else {
        context.read<FetchVideosBloc>().add(const Fetch10Videos(pageIndex: 1));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchVideosBloc, FetchVideosState>(
      listener: (context, state) async {
        if (state is ErrorToFetchVideosState) {
          debugPrint(state.message);
          ToastClass.toast(context: context, data: state.message, seconds: 3);
        }

        if (state is DoneToFetchVideos0State) {
          await videoDatabaseHelper.insertManyVideosToTable(state.videos);
          SchedulerBinding.instance.addPostFrameCallback((e) {
            Routes.mainScreen(context: context, videos: state.videos);
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Padding(
                padding: EdgeInsets.only(top: MQuery.getheight(context, 15)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      height: 160,
                      width: 300,
                      color: Colors.transparent,
                      child: Lottie.asset(
                        'assets/images/loading_lottie.json',
                        fit: BoxFit.fill,
                      ),
                    ),
                    const Align(
                      alignment: Alignment(0, -0.15),
                      child: Text(
                        "Ulearna Task",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
