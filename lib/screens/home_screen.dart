import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/photo_preview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          kToolbarHeight + MediaQuery.of(context).padding.top + 29,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            26,
            MediaQuery.of(context).padding.top + 29,
            26,
            0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('assets/svg/burger.svg', width: 25),
              const Text(
                'Discover',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  height: 1.17,
                ),
              ),
              const SizedBox(width: 25),
            ],
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 26),
        childAspectRatio: .6189,
        crossAxisSpacing: 26,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 26),
            child: const PhotoPreview(),
          ),
          Container(
            margin: const EdgeInsets.only(top: 26),
            child: const PhotoPreview(),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 26),
            child: const PhotoPreview(),
          ),
          Container(
            margin: const EdgeInsets.only(top: 26),
            child: const PhotoPreview(),
          ),
        ],
      ),
    );
  }
}
