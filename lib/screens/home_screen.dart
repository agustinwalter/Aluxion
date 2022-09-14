import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/photo_preview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBarHeight = MediaQuery.of(context).padding.top + 60;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
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
                    child: const PhotoPreview(),
                  );
                },
                childCount: 20,
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
  Widget build(_, __, ___) => SizedBox.expand(child: child);

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) =>
      maxHeight != oldDelegate.maxHeight ||
      minHeight != oldDelegate.minHeight ||
      child != oldDelegate.child;
}
