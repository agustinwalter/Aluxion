import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/custom_close_button.dart';
import '../widgets/photo_preview.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(26, 126, 26, 0),
            children: [
              Column(
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
                  const SizedBox(height: 33),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: .6189,
                    crossAxisSpacing: 26,
                    children: [
                      // Container(
                      //   margin: const EdgeInsets.only(bottom: 26),
                      //   child: const PhotoPreview(),
                      // ),
                      // Container(
                      //   margin: const EdgeInsets.only(top: 26),
                      //   child: const PhotoPreview(),
                      // ),
                      // Container(
                      //   margin: const EdgeInsets.only(bottom: 26),
                      //   child: const PhotoPreview(),
                      // ),
                      // Container(
                      //   margin: const EdgeInsets.only(top: 26),
                      //   child: const PhotoPreview(),
                      // ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 26),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.8),
                ),
                child: const Align(
                  heightFactor: 1,
                  alignment: Alignment.centerLeft,
                  child: CustomCloseButton(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
