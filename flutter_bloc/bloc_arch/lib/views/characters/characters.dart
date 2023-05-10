import 'package:bloc_arch/data/models/character_model.dart';
import 'package:bloc_arch/data/models/characters_api_models.dart';
import 'package:bloc_arch/views/characters/bloc/characters_bloc.dart';
import 'package:bloc_arch/views/characters/widgets/buttons.dart';
import 'package:bloc_arch/views/characters/widgets/characters_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CharactersBloc>().add(FetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(
                text: 'Characters',
              ),
              Tab(
                text: 'Favorites',
              )
            ]),
          ),
          body: const TabBarView(children: [_CharactersTab(), _FavoritesTab()])),
    );
  }
}

class _FavoritesTab extends StatelessWidget {
  const _FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final chars = context.select<CharactersBloc, List<CharacterModel>>(
        (value) => value.favorites);
    if (chars.isEmpty) {
      return const Center(
        child: Text('There are not favorites characters!'),
      );
    }
    return ListView.builder(
        itemCount: chars.length,
        itemBuilder: (c, i) => ListTile(
              key: UniqueKey(),
              leading: CircleAvatar(
          
                backgroundImage: NetworkImage(chars[i].image),
              ),
              title: Text(chars[i].name),
              trailing: IconButton(
                  onPressed: () {
                    context
                        .read<CharactersBloc>()
                        .add(ToggleFavorite(character: chars[i]));
                  },
                  icon: const Icon(Icons.delete,color: Colors.red,)),
            ));
  }
}

class _CharactersTab extends StatelessWidget {
  const _CharactersTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final state = context.read<CharactersBloc>();
      //TO LISTEN CHANGES JUST ONLY apiResponse changes
      final apiResponse = context.select<CharactersBloc, CharactersApiModel?>(
        (value) => value.state.apiResponse);

    final characters = apiResponse?.results ?? [];
    final pagination = apiResponse?.info;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Text('Rick y Morty Flutter Bloc Architecture',
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10,
        ),
        Expanded(child: CharactersGrid(characters: characters)),
        const SizedBox(
          height: 15,
        ),
        if (characters.isNotEmpty)
          Text('${pagination!.pageNumberCharacters} / ${pagination.pages}'),
        const SizedBox(
          height: 15,
        ),
        Buttons(pagination: pagination, state: state),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
