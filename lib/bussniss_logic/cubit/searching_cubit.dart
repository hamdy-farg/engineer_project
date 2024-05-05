import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'searching_state.dart';

class SearchingCubit extends Cubit<SearchingState> {
  SearchingCubit() : super(SearchingInitial());
  void goToSearching() {
    emit(SearchingNow());
  }

  void returnToInitial() {
    emit(SearchingInitial());
  }
}
