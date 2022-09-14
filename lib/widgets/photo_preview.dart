import 'package:flutter/material.dart';

class PhotoPreview extends StatelessWidget {
  const PhotoPreview({super.key});

  static const double _aspectRadio = 1.4437;
  static const double _aspectRadioShadow = .3907;

  @override
  Widget build(BuildContext context) {
    double imageWidth = (MediaQuery.of(context).size.width - 78) / 2;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1663084317296-bd1cfb037bbf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
            width: imageWidth,
            height: imageWidth * _aspectRadio,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: imageWidth,
              height: imageWidth * _aspectRadioShadow,
              padding: const EdgeInsets.fromLTRB(12, 19, 21, 9),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(.7),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Sky Line',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      height: 1.17,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '50 votos',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 8,
                      height: 1.17,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
