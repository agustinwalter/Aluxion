import 'package:agustin_walter_aluxion/models/unsplash_image.dart';
import 'package:agustin_walter_aluxion/screens/detail_screen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoPreview extends StatelessWidget {
  const PhotoPreview({
    super.key,
    required this.image,
    required this.index,
    required this.homeImages,
  });

  final UnsplashImage image;
  final int index;
  final bool homeImages;

  static const double _aspectRadio = 1.4437;

  @override
  Widget build(BuildContext context) {
    double imageWidth = (MediaQuery.of(context).size.width - 78) / 2;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CustomPageRoute(
            builder: (context) => DetailScreen(
              initialPage: index,
              homeImages: homeImages,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: image.imagePreviewUrl,
          imageBuilder: (_, imageProvider) => Stack(
            children: [
              Hero(
                tag: image.heroId,
                child: Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  width: imageWidth,
                  height: imageWidth * _aspectRadio,
                ),
              ),
              Positioned(
                bottom: 0,
                child: FadeInUp(
                  from: 12,
                  child: Container(
                    width: imageWidth,
                    padding: const EdgeInsets.fromLTRB(12, 19, 21, 9),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(.7),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          image.description,
                          maxLines: 2,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            height: 1.17,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${image.likes} votos',
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 8,
                            height: 1.17,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          progressIndicatorBuilder: (_, __, downloadProgress) => Container(
            color: Colors.grey.shade100,
            alignment: Alignment.center,
            child: SizedBox(
              width: 26,
              height: 2,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.grey.shade400,
                ),
                value: downloadProgress.progress,
              ),
            ),
          ),
          errorWidget: (_, __, ___) => const Center(
            child: Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

class CustomPageRoute extends MaterialPageRoute {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  CustomPageRoute({builder}) : super(builder: builder);
}
