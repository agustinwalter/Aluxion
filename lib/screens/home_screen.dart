import 'dart:ui';
import 'dart:math' as math;
import 'package:agustin_walter_aluxion/providers/aluxion_provider.dart';
import 'package:agustin_walter_aluxion/widgets/list_of_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int _nextPage = 1;
  late AluxionProvider _aluxionProvider;
  bool _loadingMoreImages = false;
  String _topic = 'Animals';
  final _drawerController = AdvancedDrawerController();
  final _topics = [
    'Animals',
    'People',
    'Architecture',
    'Nature',
    'History',
    'Fashion',
  ];

  @override
  void initState() {
    super.initState();
    _aluxionProvider = Provider.of<AluxionProvider>(context, listen: false);
    _loadMoreImages();
    _scrollController.addListener(() async {
      // It starts to load the images before reaching the end of the scroll.
      if (_scrollController.offset >
              (_scrollController.position.maxScrollExtent - 512) &&
          !_scrollController.position.outOfRange &&
          !_loadingMoreImages) {
        setState(() => _loadingMoreImages = true);
        _nextPage++;
        await _loadMoreImages();
        setState(() => _loadingMoreImages = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _drawerController.dispose();
    super.dispose();
  }

  Future<void> _loadMoreImages() async {
    await _aluxionProvider.loadOnePageOfPhotos(
      page: _nextPage,
      urlPath: '/search/photos',
      extraQueryParameters: {'query': _topic.toLowerCase()},
      takeDataFromResultsAttribute: true,
      imagesOf: ImagesOf.homeScreen,
    );
  }

  Future<void> _reloadWithNewTopic(String topic) async {
    _nextPage = 1;
    _topic = topic;
    _drawerController.hideDrawer();
    await _scrollController.animateTo(
      0,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 200),
    );
    _aluxionProvider.homeImages.clear();
    _loadMoreImages();
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight = MediaQuery.of(context).padding.top + 60;
    return AdvancedDrawer(
      backdropColor: const Color(0xFFEEEEEE),
      controller: _drawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      openRatio: .45,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _topics
                .map((topic) => TopicChip(
                      text: topic,
                      onTap: () => _reloadWithNewTopic(topic),
                    ))
                .toList(),
          ),
        ),
      ),
      child: Scaffold(
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
                          InkWell(
                            onTap: () => _drawerController.showDrawer(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 26),
                              child: SvgPicture.asset(
                                'assets/svg/burger.svg',
                                width: 26,
                              ),
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
            const ListOfImages(),
          ],
        ),
      ),
    );
  }
}

class TopicChip extends StatelessWidget {
  const TopicChip({super.key, required this.text, this.onTap});

  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        backgroundColor: Colors.white,
        avatar: CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage('assets/img/${text.toLowerCase()}.jpg'),
          backgroundColor: Colors.transparent,
        ),
        label: Text(text),
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
