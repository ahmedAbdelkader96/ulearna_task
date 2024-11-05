part of 'fetch_videos_bloc.dart';

abstract class FetchVideosEvent extends Equatable {
  const FetchVideosEvent();
}

class Fetch10Videos extends FetchVideosEvent {
  final int pageIndex;

  const Fetch10Videos({
    required this.pageIndex,
  });

  @override
  List<Object?> get props => [];
}
