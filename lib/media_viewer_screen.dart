import 'package:flutter/material.dart';

import 'data_model.dart';
import 'media_display/display_video.dart';

class MediaViewerScreen extends StatelessWidget {
  final DataModel dataModel;

  const MediaViewerScreen({Key? key, required this.dataModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DisplayVideo(dataModel: dataModel),
    );
  }
}
