part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthLoginRequisted extends AuthEvent {
  final String phone;
  final String password;

  AuthLoginRequisted({
    required this.phone,
    required this.password,
  });
}
