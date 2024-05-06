part of 'unit_bloc.dart';

@immutable
sealed class UnitEvent {}

class InsertUnit extends UnitEvent {
  final UnitModel Unit;
  InsertUnit(this.Unit);
}

class UpdateUnit extends UnitEvent {
  final UnitModel Unit;
  UpdateUnit(this.Unit);
}

class DeleteUnit extends UnitEvent {
  final int? id;
  DeleteUnit(this.id);

}
