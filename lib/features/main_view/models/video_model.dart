import 'package:task/features/main_view/models/user_model.dart';

class VideoModel {
  static DateTime fromJsonDate(String value) => DateTime.parse(value).toLocal();

  static String toJsonDate(DateTime value) => value.toUtc().toString();

  int id;
  String url;
  int userId;
  String title;
  String thumbUrl;
  int videoHeight;
  int videoWidth;
  int totalViews;
  int totalLikes;
  int totalComments;
  int totalShare;
  int totalWishlist;
  DateTime addedAt;
  UserModel userModel;
  String aspectRatio;
  int duration;

  VideoModel({
    required this.id,
    required this.url,
    required this.userId,
    required this.title,
    required this.thumbUrl,
    required this.videoHeight,
    required this.videoWidth,
    required this.totalViews,
    required this.totalLikes,
    required this.totalComments,
    required this.totalShare,
    required this.totalWishlist,
    required this.addedAt,
    required this.userModel,
    required this.aspectRatio,
    required this.duration,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
      id: json['id'],
      url: json['cdn_url'] ?? "",
      userId: json['user_id'] ?? "",
      title: json['title'] ?? "",
      thumbUrl: json['thumb_cdn_url'] ?? "",
      videoHeight: json['video_height'],
      videoWidth: json['video_width'],
      totalViews: json['total_views'],
      totalLikes: json['total_likes'],
      totalComments: json['total_comments'],
      totalShare: json['total_share'],
      totalWishlist: json['total_wishlist'],
      addedAt: VideoModel.fromJsonDate(json['byte_added_on']),
      userModel: UserModel.fromJson(json['user']),
      aspectRatio: json['video_aspect_ratio'] ?? "16:9",
      duration: json['duration'] ?? 0);

  Map<String, dynamic> toJson() => {
        "id": id,
        "cdn_url": url,
        "user_id": userId,
        "title": title,
        "thumb_cdn_url": thumbUrl,
        "video_height": videoHeight,
        "video_width": videoWidth,
        "total_views": totalViews,
        "total_likes": totalLikes,
        "total_comments": totalComments,
        "total_share": totalShare,
        "total_wishlist": totalWishlist,
        "byte_added_on": VideoModel.toJsonDate(addedAt),
        "user": userModel.toJson(),
        "video_aspect_ratio": aspectRatio,
        "duration": duration,
      };

  factory VideoModel.fromLocalStorageJson(Map<String, Object?> json) =>
      VideoModel(
        id: int.parse(json['id'].toString()),
        url: json['cdn_url'].toString(),
        userId: int.parse(json['user_id'].toString()),
        title: json['title'].toString(),
        thumbUrl: json['thumb_cdn_url'].toString(),
        videoHeight: int.parse(json['video_height'].toString()),
        videoWidth: int.parse(json['video_width'].toString()),
        totalViews: int.parse(json['total_views'].toString()),
        totalLikes: int.parse(json['total_likes'].toString()),
        totalComments: int.parse(json['total_comments'].toString()),
        totalShare: int.parse(json['total_share'].toString()),
        totalWishlist: int.parse(json['total_wishlist'].toString()),
        addedAt: VideoModel.fromJsonDate(json['byte_added_on'].toString()),
        aspectRatio: json['video_aspect_ratio'].toString(),
        duration: int.parse(json['duration'].toString()),
        userModel: UserModel(
            userId: int.parse(json['user_id'].toString()),
            fullName: json['fullname'].toString(),
            userName: json['username'].toString(),
            profilePictureUrl: json['profile_picture_cdn'].toString(),
            designation: json['designation'].toString()),
      );

  static toLocalStorage({required VideoModel video}) => {
        "id": video.id.toString(),
        "cdn_url": video.url,
        "user_id": video.userId,
        "title": video.title,
        "thumb_cdn_url": video.thumbUrl,
        "video_height": video.videoHeight,
        "video_width": video.videoWidth,
        "total_views": video.totalViews,
        "total_likes": video.totalLikes,
        "total_comments": video.totalComments,
        "total_share": video.totalShare,
        "total_wishlist": video.totalWishlist,
        "video_aspect_ratio": video.aspectRatio,
        "byte_added_on": VideoModel.toJsonDate(video.addedAt),
        "fullname": video.userModel.fullName,
        "username": video.userModel.userName,
        "profile_picture_cdn": video.userModel.profilePictureUrl,
        "designation": video.userModel.designation,
        "duration": video.duration
      };
}
