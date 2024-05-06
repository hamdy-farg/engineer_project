part of 'user_bloc.dart';

@immutable
sealed class UserState {}

// intial state before login sign up and reset
final class UserInitial extends UserState {}

class UserLoading extends UserState {}


class UserLoaded extends UserState {
  final UserModel user;
  UserLoaded(this.user);
}

class userExists extends UserState {
  final UserModel user;
  userExists(this.user);
}

class UserError extends UserState {
  final String message;
  UserError({required this.message});
}
