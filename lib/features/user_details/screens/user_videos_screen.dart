import 'package:flutter/material.dart';
import 'package:task/features/main_view/models/video_model.dart';
import 'package:task/features/main_view/widgets/loading_video_widget.dart';
import 'package:task/features/main_view/widgets/video_item.dart';
import 'package:task/global/methods_helpers_functions/media_query.dart';
import 'package:task/global/methods_helpers_functions/video_helper.dart';
import 'package:task/global/widgets/general_circular_raw_material_button.dart';
import 'package:video_player/video_player.dart';

class UserVideosScreen extends StatefulWidget {
  const UserVideosScreen(
      {super.key, required this.videos, required this.pageIndex});

  final List<VideoModel> videos;

  final int pageIndex;

  @override
  State<UserVideosScreen> createState() => _UserVideosScreenState();
}

class _UserVideosScreenState extends State<UserVideosScreen> {
  late PageController pageController =
      PageController(initialPage: widget.pageIndex,keepPage: true,viewportFraction: 1);

  late List<VideoPlayerController?> controllers = [];
  late int currentIndex =  widget.pageIndex;

  @override
  void initState() {
    super.initState();
    initiateVideos();
  }

  Future<void> initiateVideos() async {
    for (int x = 0; x < widget.videos.length; x++) {
      controllers.add(null);
    }
    setState(() {});
     function0();
     function1();
     function2();
    setState(() {});
  }

  Future<void> function0() async {
    await initiateVideoController(vid: widget.videos[widget.pageIndex], i: widget.pageIndex);
  }
  Future<void> function1() async {
    for (int x = widget.pageIndex - 1; x > 0; x--) {
      if (controllers[x] == null) {
        await initiateVideoController(vid: widget.videos[x], i: x);

      }
    }
  }
  Future<void> function2() async {
    for (int x = widget.pageIndex + 1; x < widget.videos.length; x++) {
      if (controllers[x] == null) {
           await initiateVideoController(vid: widget.videos[x], i: x);
      }
    }
  }




  Future<void> initiateVideoController({required VideoModel vid , required int i}) async {
        final fileInfo = await VideoHelper.checkCacheFor(vid.url);
        if (fileInfo == null) {
          VideoPlayerController controller =
          VideoPlayerController.networkUrl(Uri.parse(vid.url));
          controllers[i] = controller;
          setState(() {});
          await controllers[i]!.initialize();


          controllers[i]!.addListener((){
            if(!mounted){
              setState(() {});
            }
          });
          VideoHelper.cachedForUrl(vid.url);

        }
        else {
          final file = fileInfo.file;
          VideoPlayerController controller = VideoPlayerController.file(file);
          controllers[i] = controller;
          setState(() {});

          await controllers[i]!.initialize();


          controllers[i]!.addListener((){
            if(!mounted){
              setState(() {});
            }

          });


        }



  }








  @override
  void dispose() {
    pageController.dispose();
    for (var controller in controllers) {
      if (controller != null) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
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
                        Navigator.pop(context, false);
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
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),

            Expanded(child:
            PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.videos.length,
                controller: pageController,
                onPageChanged: (i) {
                  for (var e in controllers) {
                    if (e != null) {
                      e.pause();
                    }
                  }

                  setState(() {
                    currentIndex = i;
                  });
                },
                itemBuilder: (context, index) {
                  final video = widget.videos[index];
                  VideoPlayerController? controller =
                  (index >= 0 && index < controllers.length
                      ? controllers[index]
                      : null);
                  if (controller != null && currentIndex == index) {
                    return VideoItem(
                        videoPlayerController: controller, videoModel: video,
                    index: index, controllers: controllers);
                  }
                  return LoadingVideoWidget(video: video);
                }))

          ],
        ));
  }
}
