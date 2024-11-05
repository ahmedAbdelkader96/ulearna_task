abstract class IUserDetailsRepository {
  Future<dynamic> fetchUserVideos({required int userId});
}
