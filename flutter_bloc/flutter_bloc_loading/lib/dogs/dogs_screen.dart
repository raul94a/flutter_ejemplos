import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_loading/dogs/dogs_bloc.dart';

class DogScreen extends StatelessWidget {
  const DogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dogsBloc = context.watch<DogsBloc>();
    bool imageExists = dogsBloc.state.dogImage.isNotEmpty;
    bool isLoading = dogsBloc.state.loading;

    //This will trigger a snackbar in the case there's an error on the state
    //But there is another way to do it, by using the BlocListener class!!! check below
    // WidgetsBinding.instance.addPostFrameCallback((time) {
    //   if (dogsBloc.state.error) {
    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Text('There was an error!'),
    //       duration: Duration(milliseconds: 250),
    //     ));
    //     dogsBloc.add(ClearErrorEvent());
    //   }
    // });
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_bloc with loading state'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: isLoading ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Visibility(
            visible: !isLoading,
            replacement: const Center(child: CircularProgressIndicator()),
            child: Container(
              decoration: BoxDecoration(
                image: !imageExists
                    ? null
                    : DecorationImage(
                        image: NetworkImage(dogsBloc.state.dogImage),
                        fit: BoxFit.fill),
              ),
              width: size.width,
              height: 350,
              child: imageExists
                  ? null
                  : const Center(
                      child: Text('There isn\'t dog image to show!'),
                    ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: !isLoading,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      dogsBloc.add(FetchImageEvent());
                    },
                    child: const Text('Fetch dog')),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    dogsBloc.add(TriggerErrorEvent());
                  },
                  child: const Text('Trigger error'),
                ),
                BlocListener<DogsBloc, DogState>(
                  listener: (ctx, state) {
                    if (state.error) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('There was an error!'),
                        duration: Duration(milliseconds: 500),
                      ));
                      dogsBloc.add(ClearErrorEvent());
                    }
                  },
                  child: const SizedBox.shrink(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
