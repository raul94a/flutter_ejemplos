class BaseRickAndMortyApi {
  final String basePath = 'https://rickandmortyapi.com/api/';

  String allCharacters() => '${basePath}character';
  String oneCharacter(Object id) => '${allCharacters()}/$id';
  String searchCharacters(
      {String? name, String? status, String? species, String? gender}) {
    String nameQuery = '';
    String statusQuery = '';
    String speciesQuery = '';
    String genderQuery = '';
    if (name != null) {
      nameQuery = 'name=$name';
    }
    if (status != null) {
      statusQuery = 'status=$status';
    }
    if (species != null) {
      speciesQuery = 'species=$species';
    }
    if (gender != null) {
      genderQuery = 'gender=$gender';
    }
    String query =
        '?${nameQuery.isEmpty ? '' : '$nameQuery&'}${statusQuery.isEmpty ? '' : '$statusQuery&'}${speciesQuery.isEmpty ? '' : '$speciesQuery&'}${genderQuery.isEmpty ? '' : '$genderQuery&'}';
    return '${allCharacters()}/$query';
  }
}
