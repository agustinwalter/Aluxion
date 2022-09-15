import 'package:flutter/foundation.dart';
import '../api/aluxion_api.dart';
import '../models/unsplash_image.dart';

class AluxionProvider extends ChangeNotifier {
  final List<UnsplashImage> images = [];
  final List<UnsplashImage> userImages = [];

  void loadHomeImages([int page = 0]) {
    AluxionApi().getRandomImages(page: page).then((images) {
      this.images.addAll(images);
      notifyListeners();
    });
  }

  void loadUserImages([int page = 0]) {
    AluxionApi().getRandomImages(page: page).then((images) {
      userImages.addAll(images);
      notifyListeners();
    });
  }
}
