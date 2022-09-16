import 'package:agustin_walter_aluxion/models/unsplash_user.dart';
import 'package:flutter/material.dart';
import '../screens/profile_screen.dart';

class UserPreview extends StatelessWidget {
  const UserPreview({super.key, required this.homeImages, required this.user});

  final bool homeImages;
  final UnsplashUser user;

  void _navigate(BuildContext context) {
    if (homeImages) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProfileScreen(user: user)),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18.5,
          backgroundImage: NetworkImage(user.profileImageSmall),
          backgroundColor: Colors.transparent,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 12,
                height: 1.17,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _navigate(context),
              child: const Text(
                'View profile',
                style: TextStyle(
                  fontSize: 10,
                  height: 1.17,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
