import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../data_model.dart';
import 'media_decoder.dart';

class DisplayVideo extends StatefulWidget {
  final DataModel dataModel;

  const DisplayVideo({Key? key, required this.dataModel}) : super(key: key);

  @override
  State<DisplayVideo> createState() => _DisplayVideoState();
}

class _DisplayVideoState extends State<DisplayVideo> {
  late VideoPlayerController _playerController;

  Future<File> _decodeVideoToFile() async {
    final mediaDecoder = MediaDecoder();

    final File videoFile = await mediaDecoder.decodeVideo(
      '${widget.dataModel.contentId}.mp4',
      widget.dataModel.videoEncoding,
    );

    _playerController = VideoPlayerController.file(videoFile);
    await _playerController.initialize();

    return videoFile;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: _decodeVideoToFile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildSuccess(snapshot.data!);
        }

        if (snapshot.hasError) {
          return _buildError(snapshot.error.toString());
        }

        return _buildLoading();
      },
    );
  }

  Widget _buildSuccess(File videoFile) {
    _playerController.setLooping(true);
    _playerController.play();

    return Center(
      child: AspectRatio(
        aspectRatio: _playerController.value.aspectRatio,
        child: VideoPlayer(_playerController),
      ),
    );
  }

  Widget _buildError(String errorText) {
    return Center(
      child: Text(errorText),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }
}
