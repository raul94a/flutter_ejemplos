import 'package:bloc_arch/data/models/pagination_model.dart';
import 'package:bloc_arch/views/characters/bloc/characters_bloc.dart';
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
    required this.pagination,
    required this.state,
  });

  final PaginationModel? pagination;
  final CharactersBloc state;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              fixedSize: MaterialStateProperty.resolveWith(
                  (states) => Size(150, 50))),
          onPressed: pagination?.prev == null
              ? null
              : () {
                  state.add(FetchPageEvent(url: pagination!.prev!));
                },
          child: Text('Previous page'),
        ),
        const SizedBox(
          width: 15,
        ),
        ElevatedButton(
          style: ButtonStyle(
              fixedSize: MaterialStateProperty.resolveWith(
                  (states) => Size(150, 50))),
          onPressed: pagination?.next == null
              ? null
              : () {
                  state.add(FetchPageEvent(url: pagination!.next!));
                },
          child: Text('Next page'),
        )
      ],
    );
  }
}
