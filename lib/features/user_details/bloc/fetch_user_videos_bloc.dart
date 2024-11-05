import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/features/main_view/models/video_model.dart';
import 'package:task/features/user_details/controller/user_details_controller.dart';

part 'fetch_user_videos_event.dart';

part 'fetch_user_videos_state.dart';

class FetchUserVideosBloc
    extends Bloc<FetchUserVideosEvent, FetchUserVideosState> {
  final UserDetailsController controller;

  static FetchUserVideosBloc get(BuildContext context) {
    return BlocProvider.of(context);
  }

  FetchUserVideosBloc(this.controller) : super(FetchUserVideosInitial()) {
    on<FetchUserVideos>((event, emit) async {
      try {
        emit(LoadingToFetchUserVideosState());

        List<VideoModel> videos =
            await controller.fetchUserVideos(userId: event.userId);

        emit(DoneToFetchUserVideosState(videos: videos));
      } catch (exception) {
        emit(ErrorToFetchUserVideosState(message: exception.toString()));
      }
    });
  }
}
