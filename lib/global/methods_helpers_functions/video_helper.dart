import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class VideoHelper {
  static Future<FileInfo?> checkCacheFor(String url) async {
    final FileInfo? value = await DefaultCacheManager().getFileFromCache(url);
    return value;
  }

  static void cachedForUrl(String url) async {
    await DefaultCacheManager().getSingleFile(url).then((value) {
      debugPrint('downloaded successfully done for $url');
    });
  }

  static double aspectRatioFromString(String aspectRatio) {
    try {
      List<String> parts = aspectRatio.split(':');
      if (parts.length != 2) throw const FormatException("Invalid format");

      int width = int.parse(parts[0]);
      int height = int.parse(parts[1]);

      if (height == 0) throw const IntegerDivisionByZeroException();

      return width / height;
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return 0.0; // Or handle the error as needed
    }
  }

  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
