import 'package:uuid/uuid.dart';
import 'unsplash_user.dart';

class UnsplashImage {
  final String heroId;
  final String imageUrl;
  final String description;
  final int likes;
  final UnsplashUser user;

  UnsplashImage({
    required this.heroId,
    required this.imageUrl,
    required this.description,
    required this.likes,
    required this.user,
  });

  UnsplashImage.fromJSON({required Map json, required Uuid uuid})
      : heroId = uuid.v1(),
        imageUrl = json['urls']['regular'],
        description = json['description'] ?? 'Surely a cute animal',
        likes = json['likes'] ?? 0,
        user = UnsplashUser.fromJSON(json: json['user'] ?? {});

  String get imagePreviewUrl => '$imageUrl&h=300';
}
