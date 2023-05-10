import 'package:bloc_arch/data/models/character_model.dart';
import 'package:flutter/material.dart';


class CharacterDetail extends StatelessWidget {
  const CharacterDetail({super.key, required this.character});
  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SizedBox(
        width: width,
        height: size.height,
        child: Column(
          children: [
            Hero(
                tag: 'character-${character.id}',
                child: Image.network(
                  character.image,
                  width: width * 0.4,
                ))
          ],
        ),
      ),
    );
  }
}
