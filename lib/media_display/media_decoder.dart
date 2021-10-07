import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class MediaDecoder {
  static Uint8List decodeImage(String base64String) {
    return base64Decode(base64String);
  }

  static Future<File> decodeVideo(String id, String base64String) async {
    final Uint8List byteList = base64Decode(base64String);
    final Directory tempDir = await getTemporaryDirectory();

    final File file = File(join(tempDir.path, '$id.mp4'));

    if (await file.exists()) {
      return file;
    } else {
      file.writeAsBytes(byteList);
      return file;
    }
  }
}
