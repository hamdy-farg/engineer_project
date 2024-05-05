part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSucccess extends AuthState {
  final String uid;

  AuthSucccess({required this.uid}); // user Model
  
}

final class AuthFailure extends AuthState {
  final String error_message;

  AuthFailure({required this.error_message});
}
