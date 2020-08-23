part of 'drink_cubit.dart';

abstract class DrinkState extends Equatable {
  const DrinkState();

  @override
  List<Object> get props => [];
}

class DrinkInitial extends DrinkState {}

class DrinkLoadingState extends DrinkState {}

class DrinkHistoryLoadedState extends DrinkState {
  final DrinkHistoryEntity data;
  final String message;

  DrinkHistoryLoadedState({@required this.data, @required this.message});

  @override
  List<Object> get props => [data];
}

class EmptyDrinkState extends DrinkState {}

class DrinkFailureState extends DrinkState {
  final String message;

  DrinkFailureState({@required this.message});

  @override
  List<Object> get props => [message];
}
