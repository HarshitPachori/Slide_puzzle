import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageDisplay extends StatelessWidget {
  ImageDisplay({Key? key, required this.imagePath}) : super(key: key);
  String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 130,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
