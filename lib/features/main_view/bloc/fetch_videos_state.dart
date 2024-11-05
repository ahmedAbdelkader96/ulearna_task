part of 'fetch_videos_bloc.dart';

abstract class FetchVideosState extends Equatable {
  const FetchVideosState();
}

class FetchVideosInitial extends FetchVideosState {
  @override
  List<Object> get props => [];
}

class LoadingToFetchVideosState extends FetchVideosState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DoneToFetchVideos0State extends FetchVideosState {
  final List<VideoModel> videos;

  const DoneToFetchVideos0State({required this.videos});

  @override
  List<Object> get props => [];
}

class DoneToFetchVideos1State extends FetchVideosState {
  final List<VideoModel> videos;

  const DoneToFetchVideos1State({required this.videos});

  @override
  List<Object> get props => [];
}

class ErrorToFetchVideosState extends FetchVideosState {
  final String message;

  const ErrorToFetchVideosState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
