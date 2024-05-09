part of 'unit_bloc.dart';

@immutable
sealed class UnitEvent {}

class UnitInialEvent extends UnitEvent {}

class LoadUnit extends UnitEvent {
  int UID;
  int? id;
  LoadUnit({this.id, required this.UID});
}

class LoadAllUnits extends UnitEvent {
  int UID;
  LoadAllUnits({required this.UID});
}

class InsertUnit extends UnitEvent {
  final int UID;
  final UnitModel Unit;
  InsertUnit(this.Unit, this.UID);
}

class UpdateUnit extends UnitEvent {
  final UnitModel Unit;
  UpdateUnit(this.Unit);
}

class DeleteUnit extends UnitEvent {
  final int? UID;

  final int? id;
  DeleteUnit({this.id, this.UID});
}
