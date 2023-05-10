part of 'characters_bloc.dart';

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
