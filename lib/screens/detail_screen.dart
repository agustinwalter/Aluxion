import 'package:agustin_walter_aluxion/providers/aluxion_provider.dart';
import 'package:agustin_walter_aluxion/widgets/user_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.initialPage,
    required this.homeImages,
  });

  final int initialPage;
  final bool homeImages;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _descriptionVisible = false;
  final Duration _duration = const Duration(milliseconds: 100);
  double _opacity = 0;
  double _closeTop = 10;
  double _shadowBottom = -20;

  void _showOrHideDescription() {
    if (_descriptionVisible) {
      setState(() {
        _descriptionVisible = false;
        _opacity = 0;
        _closeTop = 10;
        _shadowBottom = -20;
      });
    } else {
      setState(() {
        _descriptionVisible = true;
        _opacity = 1;
        _closeTop = 26;
        _shadowBottom = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _showOrHideDescription,
        child: Consumer<AluxionProvider>(builder: (_, aluxionProvider, __) {
          final images = widget.homeImages
              ? aluxionProvider.images
              : aluxionProvider.userImages;
          return CarouselSlider(
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 1,
              initialPage: widget.initialPage,
            ),
            items: images.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return CachedNetworkImage(
                    fadeInDuration: const Duration(microseconds: 1),
                    fadeOutDuration: const Duration(microseconds: 1),
                    placeholderFadeInDuration: const Duration(microseconds: 1),
                    fadeInCurve: Curves.linear,
                    fadeOutCurve: Curves.linear,
                    imageUrl: image.imageUrl,
                    imageBuilder: (_, imageProvider) => Stack(
                      children: [
                        Hero(
                          tag: image.id,
                          child: Image(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        AnimatedPositioned(
                          top: MediaQuery.of(context).padding.top + _closeTop,
                          left: 26,
                          duration: _duration,
                          child: AnimatedOpacity(
                            opacity: _opacity,
                            duration: _duration,
                            child: GestureDetector(
                              onTap: _descriptionVisible
                                  ? () => Navigator.pop(context)
                                  : null,
                              child: SvgPicture.asset(
                                'assets/svg/close.svg',
                                width: 37,
                              ),
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          bottom: _shadowBottom,
                          duration: _duration,
                          child: AnimatedOpacity(
                            opacity: _opacity,
                            duration: _duration,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding:
                                  const EdgeInsets.fromLTRB(26, 33, 26, 33),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(.2),
                                    Colors.black.withOpacity(.7),
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Tranquilidad Marina',
                                    style: TextStyle(
                                      fontSize: 42,
                                      height: 1.17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    '200 likes',
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 1.17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(height: 26),
                                  UserPreview(homeImages: widget.homeImages),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    placeholder: (context, url) {
                      return Hero(
                        tag: image.id,
                        child: CachedNetworkImage(
                          imageUrl: image.imagePreviewUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      );
                    },
                    errorWidget: (_, __, ___) => const Center(
                      child: Icon(Icons.error),
                    ),
                  );
                },
              );
            }).toList(),
          );
        }),
      ),
    );
  }
}
