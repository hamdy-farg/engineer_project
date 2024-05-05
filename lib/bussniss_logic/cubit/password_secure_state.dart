part of 'password_secure_cubit.dart';

@immutable
sealed class PasswordSecureState {}

class PasswordIntial extends PasswordSecureState {}

class passwordVisible extends PasswordSecureState {}

@immutable
sealed class ConfirmPasswordSecureState {}

class ConfirmPasswordIntial extends ConfirmPasswordSecureState {}

class ConfirmPasswordVisible extends ConfirmPasswordSecureState {}

@immutable
sealed class PasswordSecureAtLoginState {}

class PasswordIntialAtLogin extends PasswordSecureAtLoginState {}

class PasswordVisibleAtLogin extends PasswordSecureAtLoginState {}
