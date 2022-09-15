import 'package:agustin_walter_aluxion/providers/aluxion_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'photo_preview.dart';

class ListOfImages extends StatelessWidget {
  const ListOfImages({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(26),
      sliver: Consumer<AluxionProvider>(builder: (_, aluxionProvider, __) {
        return SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (_, index) {
              final bool isEven = index % 2 == 0;
              return Container(
                margin: EdgeInsets.only(
                  bottom: isEven ? 26 : 0,
                  top: isEven ? 0 : 26,
                ),
                child: PhotoPreview(
                  image: aluxionProvider.images[index],
                  index: index,
                ),
              );
            },
            childCount: aluxionProvider.images.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .6189,
            crossAxisSpacing: 26,
          ),
        );
      }),
    );
  }
}
