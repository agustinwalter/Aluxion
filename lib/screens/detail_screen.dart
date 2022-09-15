import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/unsplash_image.dart';
import '../widgets/custom_close_button.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.image});

  final UnsplashImage image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CachedNetworkImage(
        fadeInDuration: const Duration(milliseconds: 1),
        fadeOutDuration: const Duration(milliseconds: 1),
        placeholderFadeInDuration: const Duration(milliseconds: 1),
        fadeInCurve: Curves.linear,
        fadeOutCurve: Curves.linear,
        imageUrl: image.imageUrl,
        imageBuilder: (_, imageProvider) => Stack(
          children: [
            Hero(
              tag: image.id,
              child: Image(
                image: imageProvider,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            // Positioned(
            //   bottom: 0,
            //   child: FadeInUp(
            //     from: 12,
            //     child: Container(
            //       width: imageWidth,
            //       height: imageWidth * _aspectRadioShadow,
            //       padding: const EdgeInsets.fromLTRB(12, 19, 21, 9),
            //       decoration: BoxDecoration(
            //         gradient: LinearGradient(
            //           begin: Alignment.topCenter,
            //           end: Alignment.bottomCenter,
            //           colors: [
            //             Colors.black.withOpacity(0),
            //             Colors.black.withOpacity(.7),
            //           ],
            //         ),
            //       ),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: const [
            //           Text(
            //             'Sky Line',
            //             style: TextStyle(
            //               fontWeight: FontWeight.w700,
            //               fontSize: 12,
            //               height: 1.17,
            //               color: Colors.white,
            //             ),
            //           ),
            //           SizedBox(height: 5),
            //           Text(
            //             '50 votos',
            //             style: TextStyle(
            //               fontWeight: FontWeight.w300,
            //               fontSize: 8,
            //               height: 1.17,
            //               color: Colors.white,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
        placeholder: (context, url) {
          return Hero(
            tag: image.id,
            child: CachedNetworkImage(
              imageUrl: image.imagePreviewUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          );
        },
        errorWidget: (_, __, ___) => const Center(
          child: Icon(Icons.error),
        ),
      ),

      // Stack(
      //   children: [
      //     Hero(
      //       tag: image.id,
      //       child: Image.network(
      //         image.imagePreviewUrl,
      //         height: double.infinity,
      //         width: double.infinity,
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //     const CustomCloseButton(ligthMode: true),
      //     Positioned(
      //       bottom: 0,
      //       child: FadeInUp(
      //         delay: const Duration(milliseconds: 300),
      //         duration: const Duration(milliseconds: 350),
      //         from: 25,
      //         child: Container(
      //           width: MediaQuery.of(context).size.width,
      //           padding: const EdgeInsets.fromLTRB(26, 33, 26, 46),
      //           decoration: BoxDecoration(
      //             gradient: LinearGradient(
      //               begin: Alignment.topCenter,
      //               end: Alignment.bottomCenter,
      //               colors: [
      //                 Colors.black.withOpacity(.2),
      //                 Colors.black.withOpacity(.7),
      //               ],
      //             ),
      //           ),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               FadeInUp(
      //                 delay: const Duration(milliseconds: 350),
      //                 duration: const Duration(milliseconds: 450),
      //                 child: const Text(
      //                   'Tranquilidad Marina',
      //                   style: TextStyle(
      //                     fontSize: 42,
      //                     height: 1.17,
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.w700,
      //                   ),
      //                 ),
      //               ),
      //               const SizedBox(height: 16),
      //               FadeInUp(
      //                 delay: const Duration(milliseconds: 400),
      //                 duration: const Duration(milliseconds: 450),
      //                 child: const Text(
      //                   '200 likes',
      //                   style: TextStyle(
      //                     fontSize: 14,
      //                     height: 1.17,
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.w300,
      //                   ),
      //                 ),
      //               ),
      //               const SizedBox(height: 26),
      //               FadeInUp(
      //                 delay: const Duration(milliseconds: 450),
      //                 duration: const Duration(milliseconds: 450),
      //                 child: Row(
      //                   children: [
      //                     CircleAvatar(
      //                       radius: 18.5,
      //                       child: Image.asset('assets/png/user.png'),
      //                     ),
      //                     const SizedBox(width: 8),
      //                     Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: const [
      //                         Text(
      //                           'Norman Foster',
      //                           style: TextStyle(
      //                             fontSize: 12,
      //                             height: 1.17,
      //                             color: Colors.white,
      //                             fontWeight: FontWeight.w500,
      //                           ),
      //                         ),
      //                         SizedBox(height: 8),
      //                         Text(
      //                           'View profile',
      //                           style: TextStyle(
      //                             fontSize: 10,
      //                             height: 1.17,
      //                             color: Colors.white,
      //                             fontWeight: FontWeight.w300,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
