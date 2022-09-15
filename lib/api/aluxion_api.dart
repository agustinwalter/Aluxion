import 'dart:convert';
import 'package:agustin_walter_aluxion/models/unsplash_image.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class AluxionApi {
  final _unsplashClientId =
      'a2f508640cb62f314e0e0763594d40aab1c858a7ef796184067c537a88b276aa';
  final _uuid = const Uuid();

  Future<List<UnsplashImage>> getRandomImages({int page = 0}) async {
    final url = Uri.https(
      'api.unsplash.com',
      '/photos',
      {
        'client_id': _unsplashClientId,
        'page': '$page',
      },
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return (body as List)
          .map((imageData) => UnsplashImage(
                id: _uuid.v1(),
                imageUrl: imageData['urls']['regular'],
              ))
          .toList();
    } else {
      throw Exception();
    }
  }
}
