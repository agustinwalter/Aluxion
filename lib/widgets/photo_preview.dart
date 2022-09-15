import 'package:agustin_walter_aluxion/models/unsplash_image.dart';
import 'package:agustin_walter_aluxion/screens/detail_screen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoPreview extends StatelessWidget {
  const PhotoPreview({super.key, required this.image});

  final UnsplashImage image;

  static const double _aspectRadio = 1.4437;
  static const double _aspectRadioShadow = .3907;

  @override
  Widget build(BuildContext context) {
    double imageWidth = (MediaQuery.of(context).size.width - 78) / 2;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailScreen(image: image),
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
                tag: image.id,
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
                    height: imageWidth * _aspectRadioShadow,
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
                      children: const [
                        Text(
                          'Sky Line',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            height: 1.17,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '50 votos',
                          style: TextStyle(
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
