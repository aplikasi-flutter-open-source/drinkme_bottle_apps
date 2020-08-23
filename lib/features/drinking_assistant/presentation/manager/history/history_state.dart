part of 'history_cubit.dart';

@immutable
abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoadingState extends HistoryState {}

class HistoryLoadedState extends HistoryState {
  final Map<DateTime,List> mapEventsHistoryDrink;

  HistoryLoadedState({@required this.mapEventsHistoryDrink});

  @override
  List<Object> get props => [mapEventsHistoryDrink];
}

class EmptyHistoryState extends HistoryState {}


class HistoryFailureState extends HistoryState {
  final String message;

  HistoryFailureState({@required this.message});

  @override
  List<Object> get props => [message];
}
