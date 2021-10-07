import 'package:flutter/material.dart';
import 'data_model.dart';
import 'media_display/display_image.dart';
import 'media_viewer_screen.dart';

class MediaGridViewScreen extends StatelessWidget {
  const MediaGridViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<DataModel> dataList = imagesVideoContent;
    const spaceSize = 10.0;

    return Scaffold(
      appBar: AppBar(title: const Text("Media Gridview")),
      body: Padding(
        padding: const EdgeInsets.all(spaceSize),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: spaceSize,
            mainAxisSpacing: spaceSize,
          ),
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return _buildItem(context, dataList[index]);
          },
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, DataModel dataModel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MediaViewerScreen(dataModel: dataModel)));
      },
      child: DisplayImage(dataModel: dataModel),
    );
  }
}
