import 'package:bloc/bloc.dart';
import 'package:engneers_app/data/model/unit_model.dart';
import 'package:engneers_app/db/sqldb.dart';
import 'package:meta/meta.dart';

part 'unit_event.dart';
part 'unit_state.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  UnitBloc() : super(UnitInitial()) {
    on<InsertUnit>((event, emit) async {
      emit(UnitLoading());
      try {
        await InsertUnit(event.Unit);
        final List<UnitModel> units =
            await SqlDb().readData("select * from users;");
        emit(UnitLoaded(units));
      } catch (e) {
        emit(UnitError(message: e.toString()));
      }
    });

    on<UpdateUnit>((event, emit) async {
      emit(UnitLoading());
      try {
        UnitModel unit = event.Unit;
        final List<UnitModel> units = await SqlDb().insertData(
            "insert into users(full_name, phone_number, password)", [unit]);
        emit(UnitLoaded(units));
      } catch (e) {
        emit(UnitError(message: e.toString()));
      }
    });
  }
}
