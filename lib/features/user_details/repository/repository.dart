import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:task/features/main_view/models/video_model.dart';
import 'package:task/features/user_details/repository/irepository.dart';
import 'package:task/global/methods_helpers_functions/exception_handler.dart';

class UserDetailsRepository implements IUserDetailsRepository {
  @override
  Future<dynamic> fetchUserVideos({required int userId}) async {
    try {
      final url = dotenv.env['apiForAllVideos'].toString();
      final response = await http.get(Uri.parse(url));

      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> jsonData = jsonDecode(response.body);

          List<dynamic> data1 = jsonData['data']['data'];
          List<VideoModel> videos = data1
              .map((e) => VideoModel.fromJson(e))
              .where((e) => e.userId == userId)
              .toList();
          return videos;
        case 400: //Bad request
          throw BadRequestException(jsonDecode(response.body)['message']);
        case 401: //Unauthorized
          throw UnAuthorizedException(jsonDecode(response.body)['message']);
        case 403: //Forbidden
          throw UnAuthorizedException(jsonDecode(response.body)['message']);
        case 404: //Resource Not Found
          throw NotFoundException(jsonDecode(response.body)['message']);
        case 500: //Internal Server Error
        default:
          throw FetchDataException(
              'Something went wrong! ${response.statusCode}');
      }
    } catch (e) {
      throw ExceptionHandlers().getExceptionString(e);
    }
  }
}
