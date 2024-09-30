import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImageZoom extends StatelessWidget {
  final String imageUrl;

  const ImageZoom(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: PhotoView(
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            imageProvider: CachedNetworkImageProvider(imageUrl),
            minScale: PhotoViewComputedScale.contained,
            scaleStateChangedCallback: (PhotoViewScaleState state) {},
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.white),
              child: const RotatedBox(
                quarterTurns: 30,
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
