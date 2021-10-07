import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaDecoder {
  static Uint8List decodeImage(String base64String) {
    return base64Decode(base64String);
  }

  Future<File?> decodeVideo(String fileName, String base64String) async {
    if (Platform.isAndroid) {
      return _decodeVideoToFile(fileName, base64String);
    } else {
      return _decodeVideoToCached(fileName, base64String);
    }
  }

  Future<File> _decodeVideoToCached(
      String fileName, String base64String) async {
    final Uint8List byteList = base64Decode(base64String);
    final Directory tempDir = await getTemporaryDirectory();
    final File file = File(join(tempDir.path, '$fileName.mp4'));

    if (!await file.exists()) {
      await file.writeAsBytes(byteList);
    }

    return file;
  }

  Future<File?> _decodeVideoToFile(String fileName, String base64String) async {
    if (!await _requestPermission(Permission.storage)) return null;

    final Directory dir = await _getExternalDir();
    final Uint8List byteList = base64Decode(base64String);
    final File file = File(join(dir.path, '$fileName.mp4'));

    if (!await file.exists()) {
      await file.writeAsBytes(byteList);
    }

    return file;
  }

  Future<Directory> _getExternalDir() async {
    final Directory externalDir = (await getExternalStorageDirectory())!;
    List<String> paths = externalDir.path.split("/");

    String newPath = "";
    for (int i = 1; i < paths.length; i++) {
      String folder = paths[i];
      if (folder != "Android") {
        newPath += "/" + folder;
      } else {
        break;
      }
    }
    newPath += "/DecodedVideos";

    final Directory dir = Directory(newPath);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    return dir;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
}
