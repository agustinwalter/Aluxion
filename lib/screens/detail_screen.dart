import 'package:agustin_walter_aluxion/widgets/custom_close_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1663084317296-bd1cfb037bbf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const CustomCloseButton(ligthMode: true),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(26, 33, 26, 46),
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
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18.5,
                        child: Image.asset('assets/png/user.png'),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Norman Foster',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.17,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'View profile',
                            style: TextStyle(
                              fontSize: 10,
                              height: 1.17,
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
