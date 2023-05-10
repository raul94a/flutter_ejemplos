// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_arch/data/api/characters_api.dart';
import 'package:bloc_arch/data/models/character_model.dart';
import 'package:bloc_arch/data/models/characters_api_models.dart';
import 'package:bloc_arch/data/models/pagination_model.dart';
import 'package:bloc_arch/data/repositories/characters_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'characters_state.dart';
part 'characters_events.dart';

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
