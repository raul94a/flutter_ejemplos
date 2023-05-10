part of 'characters_bloc.dart';
class CharactersState {
  final bool loading;
  final bool error;
  final CharactersApiModel? apiResponse;
  final List<CharacterModel> favorites;
  CharactersState(
      {required this.loading,
      required this.error,
      required this.apiResponse,
      this.favorites = const []});

  CharactersState copyWith({
    bool? loading,
    bool? error,
    List<CharacterModel>? favorites,
    CharactersApiModel? apiResponse,
  }) {
    return CharactersState(
      favorites: favorites ?? this.favorites,
      loading: loading ?? this.loading,
      error: error ?? this.error,
      apiResponse: apiResponse ?? this.apiResponse,
    );
  }
}
