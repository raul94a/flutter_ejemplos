// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_arch/data/api/characters_api.dart';
import 'package:bloc_arch/data/models/character_model.dart';
import 'package:bloc_arch/data/models/characters_api_models.dart';
import 'package:bloc_arch/data/models/pagination_model.dart';
import 'package:bloc_arch/data/repositories/characters_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

abstract class CharactersEvents {}

class FetchEvent extends CharactersEvents {}

class FetchPageEvent extends CharactersEvents {
  final String url;
  FetchPageEvent({required this.url});
}

class ToggleFavorite extends CharactersEvents {
  final CharacterModel character;
  ToggleFavorite({required this.character});
}

class CharactersBloc extends Bloc<CharactersEvents, CharactersState> {
  final repo = CharactersRepository(api: CharactersApi());
  CharactersBloc()
      : super(
            CharactersState(loading: false, error: false, apiResponse: null)) {
    on<FetchEvent>(_fetchChars);
    on<FetchPageEvent>(fetchPage);
    on<ToggleFavorite>(_toggleFavorite);
  }

  Future<void> _fetchChars(FetchEvent event, Emitter emit) async {
    emit(state.copyWith(loading: true));
    final response = await repo.getAll();
    emit(state.copyWith(loading: false, apiResponse: response));
  }

  Future<void> fetchPage(FetchPageEvent event, Emitter emit) async {
    emit(state.copyWith(loading: true));
    final response = await repo.getPage(event.url);
    emit(state.copyWith(loading: false, apiResponse: response));
  }

  void _toggleFavorite(ToggleFavorite event, Emitter emit) {
    final char = event.character;
    bool isFav = favorites.any((element) => element == char);
    List<CharacterModel> favs = [...favorites];
    if (isFav) {
      favs.remove(char);
    } else {
      favs.add(char);
    }
    emit(state.copyWith(favorites: [...favs]));
  }

  List<CharacterModel> get characters => state.apiResponse?.results ?? [];
  List<CharacterModel> get favorites => state.favorites;
  PaginationModel? get pagination => state.apiResponse?.info;
  bool get loading => state.loading;
}
