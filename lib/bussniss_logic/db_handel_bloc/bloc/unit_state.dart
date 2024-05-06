part of 'unit_bloc.dart';

@immutable
sealed class UnitState {}

final class UnitInitial extends UnitState {}

class UnitLoading extends UnitState {}

class UnitLoaded extends UnitState {
  final List<UnitModel> Units;
  UnitLoaded(this.Units);
}

class UnitError extends UnitState {
  final String message;
  UnitError({required this.message});
}
