import '../repository/repository.dart';

class VideosController {
  final repo = VideosRepository();

  Future<dynamic> fetch10Videos({required int pageIndex}) {
    return repo.fetch10Videos(pageIndex: pageIndex);
  }
}
