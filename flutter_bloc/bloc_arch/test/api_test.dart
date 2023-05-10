import 'package:bloc_arch/data/api/characters_api.dart';
import 'package:bloc_arch/data/repositories/characters_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('CharactersAPI', () async {
    final repository = CharactersRepository(api: CharactersApi());
    final characters = (await repository.getAll()).results;
    expect(characters, isNot(null));
    expect(characters.length, greaterThan(1)); 
  });
}
