import 'package:bloc/bloc.dart';
import 'package:engineer_app/data/model/unit_model.dart';
import 'package:engineer_app/db/sqldb.dart';

import 'package:meta/meta.dart';

part 'unit_event.dart';
part 'unit_state.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  UnitBloc() : super(UnitInitial()) {
    on<UnitInialEvent>((event, emit) {
      emit(UnitInitial());
    });
    on<LoadUnit>((event, emit) async {
      emit(UnitLoading());
      try {
        final UnitModel? unit =
            await GetData().getUnit(id: event.id!, UID: event.UID);
        if (unit!.customer_name == "1") {
          emit(UnitError(message: " "));
        } else {
          emit(UnitLoaded(unit));
        }
      } catch (e) {
        emit(
          UnitError(message: e.toString()),
        );
      }
    });

    // to load all item data
    on<LoadAllUnits>((event, emit) async {
      // loading state
      emit(UnitLoading());

      try {
        final List<UnitModel> units =
            await GetData().getAllUnits(UID: event.UID);

        if (units.length < 1) {
          emit(UnitError(message: "there is no Units until now"));
        } else {
          emit(AllUnitsLoaded(units));
        }
      } catch (e) {
        emit(
          UnitError(message: "${event.UID} sssssssssss"),
        );
      }
    });

    on<InsertUnit>((event, emit) async {
      emit(UnitLoading());
      try {
        if (await InsertData().insertUnit(event.Unit) == 0) {
          emit(UnitError(message: "error accured"));
        } else {
          final List<UnitModel> units =
              await GetData().getAllUnits(UID: event.UID!);
          emit(AllUnitsLoaded(units));
        }
      } catch (e) {
        emit(UnitError(message: e.toString()));
      }
    });

    on<DeleteUnit>((event, emit) async {
      emit(UnitLoading());
      try {
        print("ddddddswqq");

        await DeleteData().deleteUnit(event.id);
        final List<UnitModel> units =
            await GetData().getAllUnits(UID: event.UID!);
        print("dddddddddddddddddswqq");
        emit(AllUnitsLoaded(units));
      } catch (e) {
        emit(UnitError(message: e.toString()));
      }
    });
    on<UpdateUnit>((event, emit) async {
      emit(UnitLoading());
      try {
        print("9999999999999999999999999990");

        await UpdataData().updateUnit(event.Unit);
        print(")))))))))))))))))))))))))))))))))))))))0");

        final List<UnitModel> units =
            await GetData().getAllUnits(UID: event.Unit.UID);
        print("dddddddddddddddddswqq");
        emit(AllUnitsLoaded(units));
      } catch (e) {
        emit(UnitError(message: e.toString()));
      }
    });
  }
}
