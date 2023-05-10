import 'dart:convert';

import 'package:bloc_arch/data/api/base_rick_and_morty_api.dart';
import 'package:http/http.dart';

class CharactersApi extends BaseRickAndMortyApi {
  CharactersApi() : super();
  Future<Map<String, dynamic>> getAll() async {
    final uri = Uri.parse(allCharacters());
    try {
      final response = await get(uri);
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> getOne(Object id) async {
    final uri = Uri.parse(oneCharacter(id));
    try {
      final response = await get(uri);
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }
 Future<Map<String, dynamic>> getPage(String url) async {
    final uri = Uri.parse(url);
    try {
      final response = await get(uri);
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }
}
