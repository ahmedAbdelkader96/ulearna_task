import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/features/main_view/bloc/fetch_videos_bloc.dart';
import 'package:task/features/main_view/controller/videos_controller.dart';
import 'package:task/features/user_details/bloc/fetch_user_videos_bloc.dart';
import 'package:task/features/user_details/controller/user_details_controller.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<FetchVideosBloc>(
        create: (_) => FetchVideosBloc(VideosController())),
    BlocProvider<FetchUserVideosBloc>(
        create: (_) => FetchUserVideosBloc(UserDetailsController())),
  ];
}
