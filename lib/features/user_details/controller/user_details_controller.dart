import 'package:task/features/user_details/repository/repository.dart';

class UserDetailsController {
  final repo = UserDetailsRepository();

  Future<dynamic> fetchUserVideos({required int userId}) {
    return repo.fetchUserVideos(userId: userId);
  }
}
