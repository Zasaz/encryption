import 'package:flutter/material.dart';

import '../data_model.dart';
import 'media_decoder.dart';

class DisplayImage extends StatelessWidget {
  final DataModel dataModel;

  const DisplayImage({Key? key, required this.dataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image.memory(
        MediaDecoder.decodeImage(dataModel.imageEncoding),
      ),
    );
  }
}
