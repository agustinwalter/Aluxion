import 'package:agustin_walter_aluxion/models/unsplash_image.dart';
import 'package:flutter/material.dart';
import 'photo_preview.dart';

class ListOfImages extends StatelessWidget {
  const ListOfImages({super.key, required this.images});

  final List<UnsplashImage> images;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(26),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            final bool isEven = index % 2 == 0;
            return Container(
              margin: EdgeInsets.only(
                bottom: isEven ? 26 : 0,
                top: isEven ? 0 : 26,
              ),
              child: PhotoPreview(image: images[index]),
            );
          },
          childCount: images.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .6189,
          crossAxisSpacing: 26,
        ),
      ),
    );
  }
}
