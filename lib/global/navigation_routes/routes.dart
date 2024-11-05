import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/features/main_view/models/user_model.dart';
import 'package:task/features/main_view/models/video_model.dart';
import 'package:task/features/main_view/screens/main_screen.dart';
import 'package:task/features/user_details/screens/user_profile_screen.dart';
import 'package:task/features/user_details/screens/user_videos_screen.dart';

class Routes {
  static Future<dynamic> mainScreen(
      {required BuildContext context, required List<VideoModel> videos}) async {
    return Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => MainScreen(videos: videos)),
        (Route<dynamic> route) => false);
  }

  static Future<dynamic> userProfileScreen(
      {required BuildContext context, required UserModel userModel}) async {
    return Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => UserProfileScreen(userModel: userModel)),
    );
  }

  static Future<dynamic> userVideosScreen(
      {required BuildContext context,
      required List<VideoModel> videos,
      required int pageIndex}) async {
    return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              UserVideosScreen(videos: videos, pageIndex: pageIndex)),
    );
  }
}
