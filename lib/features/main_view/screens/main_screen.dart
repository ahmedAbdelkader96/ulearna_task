import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/features/main_view/bloc/fetch_videos_bloc.dart';
import 'package:task/features/main_view/models/video_model.dart';
import 'package:task/features/main_view/widgets/loading_video_widget.dart';
import 'package:task/features/main_view/widgets/video_item.dart';
import 'package:task/global/methods_helpers_functions/local_storage.dart';
import 'package:task/global/methods_helpers_functions/toast.dart';
import 'package:task/global/methods_helpers_functions/video_helper.dart';
import 'package:video_player/video_player.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.videos});

  final List<VideoModel> videos;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int apiPageIndex;

  int currentIndex = 0;
  List<VideoModel> videos = [];
  VideoDatabaseHelper videoDatabaseHelper = VideoDatabaseHelper();
  late List<VideoPlayerController?> controllers = [];
  List<bool> isLoadingForN10 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initiateVideosControllerN(vids: widget.videos, functionIndex: 0);
    int apiPageIndexOld = widget.videos.length ~/ 10;
    apiPageIndex = apiPageIndexOld;
  }

  @override
  void dispose() {
    // Dispose of controllers
    for (var controller in controllers) {
      if (controller != null) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  Future<void> initiateVideosControllerN(
      {required List<VideoModel> vids, required int functionIndex}) async {
    isLoadingForN10.add(true);

    videos.addAll(vids);

    setState(() {});

    for (int x = 0; x < vids.length; x++) {
      final fileInfo = await VideoHelper.checkCacheFor(vids[x].url);
      if (fileInfo == null) {
        VideoPlayerController controller =
            VideoPlayerController.networkUrl(Uri.parse(vids[x].url));

        controllers.add(controller);
        setState(() {});

        try {
          await controller.initialize().then((e) {
            setState(() {});
          });
        } catch (e) {
          debugPrint(e.toString());
        }

        VideoHelper.cachedForUrl(vids[x].url);
        setState(() {});
      } else {
        final file = fileInfo.file;
        VideoPlayerController controller = VideoPlayerController.file(file);

        controllers.add(controller);
        setState(() {});

        try {
          await controller.initialize().then((e) {
            setState(() {});
          });
        } catch (e) {
          debugPrint(e.toString());
        }

        setState(() {});
      }
    }

    setState(() {
      isLoadingForN10[functionIndex] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: BlocConsumer<FetchVideosBloc, FetchVideosState>(
          listener: (context, state) async {
            if (state is ErrorToFetchVideosState) {
              debugPrint(state.message);
              ToastClass.toast(
                  context: context, data: state.message, seconds: 3);
            }

            if (state is DoneToFetchVideos1State) {
              await initiateVideosControllerN(
                  vids: state.videos, functionIndex: 1);
              await videoDatabaseHelper.insertManyVideosToTable(state.videos);
              setState(() {});
            }
          },
          builder: (context, state) {
            if (controllers.isNotEmpty) {
              return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: videos.length,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (i) {
                    for (var e in controllers) {
                      if (e != null) {
                        e.pause();
                      }
                    }

                    setState(() {
                      currentIndex = i;
                    });

                    bool? value = (i >= 0 && i < isLoadingForN10.length
                        ? isLoadingForN10[i]
                        : null);

                    if (value == null) {
                      if (i == videos.length - 5) {
                        setState(() {
                          apiPageIndex++;
                        });
                        context
                            .read<FetchVideosBloc>()
                            .add(Fetch10Videos(pageIndex: apiPageIndex));
                      }
                    }
                  },
                  itemBuilder: (context, index) {
                    final video = videos[index];
                    VideoPlayerController? controller =
                        (index >= 0 && index < controllers.length
                            ? controllers[index]
                            : null);

                    if (controller != null &&
                        //controller.value.isInitialized &&
                        currentIndex == index) {
                      return VideoItem(
                          videoPlayerController: controller,
                          videoModel: video,
                          controllers: controllers);
                    }
                    return LoadingVideoWidget(video: video);
                  });
            }

            if (state is ErrorToFetchVideosState) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            return const LoadingVideoWidget(video: null);
          },
        ));
  }
}
