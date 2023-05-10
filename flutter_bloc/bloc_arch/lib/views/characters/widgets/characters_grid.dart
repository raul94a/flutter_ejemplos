import 'package:bloc_arch/data/models/character_model.dart';
import 'package:bloc_arch/views/characters/bloc/characters_bloc.dart';
import 'package:bloc_arch/views/characters/character_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_fade/image_fade.dart';

class CharactersGrid extends StatelessWidget {
  const CharactersGrid({
    super.key,
    required this.characters,
  });

  final List<CharacterModel> characters;

  @override
  Widget build(BuildContext context) {
    bool loading = context.select<CharactersBloc,bool>((v) => v.loading);
    if(loading){
      return const Center(child: CircularProgressIndicator.adaptive(),);
    }
    return GridView.builder(
        itemCount: characters.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, mainAxisSpacing: 15.0, crossAxisSpacing: 0.0),
        itemBuilder: (ctx, i) {
          final character = characters[i];
          return _CharacterGridTile(key: UniqueKey(),character: character);
        });
  }
}

class _CharacterGridTile extends StatefulWidget {
  const _CharacterGridTile({
    super.key,
    required this.character,
  });

  final CharacterModel character;

  @override
  State<_CharacterGridTile> createState() => _CharacterGridTileState();
}

class _CharacterGridTileState extends State<_CharacterGridTile> {
  ValueNotifier<bool> isFav = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    isFav.value = context
        .read<CharactersBloc>()
        .favorites
        .any((e) => e.id == widget.character.id);
  }

  @override
  void dispose() {
    isFav.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      key: widget.key,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8.0)),
        child: GridTile(
          key: UniqueKey(),
          //header: Image.network(character.image),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) =>
                        CharacterDetail(character: widget.character))),
                child: Hero(
                  tag: 'character-${widget.character.id}',
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    child: ImageFade(
                        loadingBuilder: (context, progress, chunkEvent) =>
                            Center(
                              child: CircularProgressIndicator(
                                value: progress,
                              ),
                            ),
                        image: NetworkImage(widget.character.image)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Row(
                      children: [
                        Text('Name: ${widget.character.name}'),
                        const SizedBox(
                          width: 10,
                        ),
                        ValueListenableBuilder(
                        
                            valueListenable: isFav,
                            builder: (context, value, _) {
                              return IconButton(
                              
                                  onPressed: () {
                                    context.read<CharactersBloc>().add(
                                        ToggleFavorite(
                                            character: widget.character));
                                    isFav.value = !isFav.value;
                                  },
                                  icon: value
                                      ? const Icon(Icons.favorite)
                                      : const Icon(
                                          Icons.favorite_border_outlined));
                            })
                      ],
                    ),
                    Text('Status: ${widget.character.status}'),
                    Text('Species: ${widget.character.species}'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
