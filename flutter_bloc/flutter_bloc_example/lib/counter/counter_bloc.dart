// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

///  Instructions:
///  
///  1. Declare the state
///  2. Declare the events that will trigger the state change
///  3. Declare the Bloc class, using the state and the events
/// 
///  These steps are mostly in any case, but obviously it can depend on the use case.
/// 
///  

//1. Your state. In this case it is quite simple
class CounterState {
  final int counter;
  const CounterState({this.counter = 0});

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }
}

//2. Declare your event abstract class in order to extend it to the others event classes
abstract class CounterEvent {}

//This class will be called when the counter wants to be increased by one
class IncreaseEvent extends CounterEvent {}

//This class will be called when the counter wants to be decreased by one
class DecreaseEvent extends CounterEvent {}

//3. Now, declare the BLoC

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  //here we init the state
  CounterBloc() : super(const CounterState(counter: 0)){
    //inside the constructor body we must declare the events
    on<IncreaseEvent>(_increaseByOne);
    on<DecreaseEvent>(_decreaseByOne);

  }

  //We're gonna see how to update the state using the normal way or
  //by using the recommended way with the copyWith method
  //This method needs to be implemented

  _increaseByOne(IncreaseEvent event, Emitter emit){
    final counter = state.counter + 1;
    emit(CounterState(counter: counter));
  }

  _decreaseByOne(DecreaseEvent event, Emitter emit){
       final counter = state.counter - 1;
    emit(state.copyWith(counter: counter));
  }
}
