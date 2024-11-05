class UserModel {
  int userId;

  String fullName;
  String userName;
  String profilePictureUrl;
  String designation;

  UserModel({
    required this.userId,
    required this.fullName,
    required this.userName,
    required this.profilePictureUrl,
    required this.designation,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json['user_id'],
        fullName: json['fullname'] ?? "",
        userName: json['username'] ?? "",
        profilePictureUrl: json['profile_picture_cdn'] ?? "",
        designation: json['designation'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "fullname": fullName,
        "username": userName,
        "profile_picture_cdn": profilePictureUrl,
        "designation": designation,
      };
}
