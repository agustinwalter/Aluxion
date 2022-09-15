import 'dart:ui';
import 'dart:math' as math;
import 'package:agustin_walter_aluxion/api/aluxion_api.dart';
import 'package:agustin_walter_aluxion/models/unsplash_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/photo_preview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<UnsplashImage> _images = [];
  final ScrollController _scrollController = ScrollController();
  int _nextPage = 0;

  @override
  void initState() {
    super.initState();
    _getRandomImages();
    _scrollController.addListener(() {
      // It starts to load the images before reaching the end of the scroll.
      if (_scrollController.offset >
              (_scrollController.position.maxScrollExtent - 512) &&
          !_scrollController.position.outOfRange) {
        _nextPage++;
        _getRandomImages(_nextPage);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _getRandomImages([int page = 0]) {
    AluxionApi().getRandomImages(page: page).then((images) {
      setState(() => _images.addAll(images));
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight = MediaQuery.of(context).padding.top + 60;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 26)),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              minHeight: appBarHeight,
              maxHeight: appBarHeight,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 26),
                          child: SvgPicture.asset(
                            'assets/svg/burger.svg',
                            width: 26,
                          ),
                        ),
                        const Text(
                          'Discover',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 24,
                            height: 1.17,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 52)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
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
                    child: PhotoPreview(image: _images[index]),
                  );
                },
                childCount: _images.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .6189,
                crossAxisSpacing: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(context, shrinkOffset, overlapsContent) =>
      SizedBox.expand(child: child);

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) =>
      maxHeight != oldDelegate.maxHeight ||
      minHeight != oldDelegate.minHeight ||
      child != oldDelegate.child;
}
