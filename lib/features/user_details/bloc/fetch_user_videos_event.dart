part of 'fetch_user_videos_bloc.dart';

abstract class FetchUserVideosEvent extends Equatable {
  const FetchUserVideosEvent();
}

class FetchUserVideos extends FetchUserVideosEvent {
  final int userId;

  const FetchUserVideos({
    required this.userId,
  });

  @override
  List<Object?> get props => [];
}
