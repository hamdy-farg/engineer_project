import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'area_state.dart';

class AreaCubit extends Cubit<AreaState> {
  AreaCubit() : super(AreaInitial());

  void areaInitial() {
    emit(AreaInitial());
  }

  void changeArea() {
    emit(AreaChange());
  }
}
