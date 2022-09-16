class UnsplashUser {
  final String name;
  final String username;
  final String profileImageSmall;
  final String profileImageLarge;
  final String bio;

  UnsplashUser({
    required this.name,
    required this.username,
    required this.profileImageSmall,
    required this.profileImageLarge,
    required this.bio,
  });

  UnsplashUser.fromJSON({required Map json})
      : name = json['name'] ?? 'John Doe',
        username = json['username'] ?? '',
        profileImageSmall = json['profile_image']['small'],
        profileImageLarge = json['profile_image']['large'],
        bio = json['bio'] ??
            'This person does not have much to say about himself.';
}
