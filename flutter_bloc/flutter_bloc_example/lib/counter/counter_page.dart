import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/counter/counter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    //a way to access the CounterBloc through the context. With the watch  method when the state changes
    //all the widgets from below will be rebuilt. In some cases you want this, but not in others.
    //How to rebuilt only part of the UI is not covered in this repo.
    final counterBloc = context.watch<CounterBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Bloc example'),
      ),
      body: SizedBox(
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      'The counter has a value of ${counterBloc.state.counter}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            //here we're gonna trigger the counter increment
                            //as you can see, this is triggered with the add method!
                            counterBloc.add(IncreaseEvent());
                          },
                          child: const Text('Increment by one')),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            //here we're gonna trigger the counter decrement
                            counterBloc.add(DecreaseEvent());
                          },
                          child: const Text('Decrement by one')),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
