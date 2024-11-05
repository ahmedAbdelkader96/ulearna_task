import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/features/main_view/controller/videos_controller.dart';
import 'package:task/features/main_view/models/video_model.dart';

part 'fetch_videos_event.dart';

part 'fetch_videos_state.dart';

class FetchVideosBloc extends Bloc<FetchVideosEvent, FetchVideosState> {
  final VideosController controller;

  static FetchVideosBloc get(BuildContext context) {
    return BlocProvider.of(context);
  }

  FetchVideosBloc(this.controller) : super(FetchVideosInitial()) {
    on<Fetch10Videos>((event, emit) async {
      try {
        emit(LoadingToFetchVideosState());

        if (event.pageIndex == 1) {
          List<VideoModel> videos =
              await controller.fetch10Videos(pageIndex: event.pageIndex);

          emit(DoneToFetchVideos0State(videos: videos));
        } else {
          List<VideoModel> videos =
              await controller.fetch10Videos(pageIndex: event.pageIndex);
          emit(DoneToFetchVideos1State(videos: videos));
        }
      } catch (exception) {
        emit(ErrorToFetchVideosState(message: exception.toString()));
      }
    });
  }
}
