part of 'searching_cubit.dart';

@immutable
sealed class SearchingState {}

final class SearchingInitial extends SearchingState {}

final class SearchingNow extends SearchingState {}
