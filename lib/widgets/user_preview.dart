import 'package:flutter/material.dart';
import '../screens/profile_screen.dart';

class UserPreview extends StatelessWidget {
  const UserPreview({super.key, required this.homeImages});

  final bool homeImages;

  void _navigate(BuildContext context) {
    if (homeImages) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const ProfileScreen();
          },
        ),
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
          child: Image.asset('assets/png/user.png'),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Norman Foster',
              style: TextStyle(
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
