import 'package:bloc_arch/data/api/characters_api.dart';
import 'package:bloc_arch/data/models/character_model.dart';
import 'package:bloc_arch/data/models/characters_api_models.dart';

class CharactersRepository {
  final CharactersApi api;
  const CharactersRepository({required this.api});

  Future<CharactersApiModel> getAll() async {
    final data = await api.getAll();
    return CharactersApiModel.fromMap(data);
  }

  Future<CharactersApiModel> getPage(String url) async {
    final data = await api.getPage(url);
    return CharactersApiModel.fromMap(data);
  }

  Future<CharacterModel> getOne(Object id) async {
    final data = await api.getOne(id);
    return CharacterModel.fromMap(data);
  }
}
