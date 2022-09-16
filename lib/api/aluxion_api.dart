import 'dart:convert';
import 'package:agustin_walter_aluxion/models/unsplash_image.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class AluxionApi {
  static const _unsplashClientId =
      'a2f508640cb62f314e0e0763594d40aab1c858a7ef796184067c537a88b276aa';
  final _uuid = const Uuid();

  Future<List<UnsplashImage>> getOnePageOfPhotos({
    int page = 1,
    required String urlPath,
    Map<String, dynamic>? extraQueryParameters,
    bool takeDataFromResultsAttribute = false,
  }) async {
    final Map<String, dynamic> queryParameters = {
      'client_id': _unsplashClientId,
      'page': '$page',
    };
    if (extraQueryParameters != null) {
      queryParameters.addAll(extraQueryParameters);
    }
    final url = Uri.https('api.unsplash.com', urlPath, queryParameters);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final images = takeDataFromResultsAttribute
          ? jsonDecode(response.body)['results']
          : jsonDecode(response.body);
      return (images as List)
          .map((json) => UnsplashImage.fromJSON(json: json, uuid: _uuid))
          .toList();
    } else {
      throw Exception();
    }
  }
}
