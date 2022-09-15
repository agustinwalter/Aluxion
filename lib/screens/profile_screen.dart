import 'dart:ui';
import 'package:agustin_walter_aluxion/widgets/list_of_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../api/aluxion_api.dart';
import '../models/unsplash_image.dart';
import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<UnsplashImage> _images = [];
  final ScrollController _scrollController = ScrollController();
  int _nextPage = 0;
  bool _showAppbarTitle = false;

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
      if (_scrollController.offset > 120) {
        setState(() => _showAppbarTitle = true);
      } else {
        setState(() => _showAppbarTitle = false);
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
            floating: true,
            delegate: SliverAppBarDelegate(
              minHeight: appBarHeight,
              maxHeight: appBarHeight,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 26),
                          child: SvgPicture.asset(
                            'assets/svg/close.svg',
                            width: 36,
                            color: Colors.black,
                          ),
                        ),
                        if (_showAppbarTitle)
                          const Text(
                            'Norman Foster',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              height: 1.17,
                              color: Colors.black,
                            ),
                          ),
                        if (_showAppbarTitle) const SizedBox(width: 52)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(26, 33, 26, 7),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 31.5,
                        child: Image.asset('assets/png/user.png'),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Norman Foster',
                              style: TextStyle(
                                fontSize: 22,
                                height: 1.17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'British architect whose company, Foster + Partners, maintains an international design practice famous for high-tech architecture.',
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.17,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 33),
                  const Text(
                    'My Photos',
                    style: TextStyle(
                      fontSize: 42,
                      height: 1.17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListOfImages(images: _images),
        ],
      ),
    );
  }
}
