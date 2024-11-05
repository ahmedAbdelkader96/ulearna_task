part of 'fetch_user_videos_bloc.dart';

abstract class FetchUserVideosState extends Equatable {
  const FetchUserVideosState();
}

class FetchUserVideosInitial extends FetchUserVideosState {
  @override
  List<Object> get props => [];
}

class LoadingToFetchUserVideosState extends FetchUserVideosState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DoneToFetchUserVideosState extends FetchUserVideosState {
  final List<VideoModel> videos;

  const DoneToFetchUserVideosState({required this.videos});

  @override
  List<Object> get props => [];
}

class ErrorToFetchUserVideosState extends FetchUserVideosState {
  final String message;

  const ErrorToFetchUserVideosState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
