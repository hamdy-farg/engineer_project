import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'password_secure_state.dart';

class PasswordSecureCubit extends Cubit<PasswordSecureState> {
  PasswordSecureCubit() : super(PasswordIntial());
  bool secure = false;

  void secureTextPassword() {
    emit(PasswordIntial());
  }

  void unsecureTextPassword() {
    emit(passwordVisible());
  }
}

class ConfirmPasswordSecureCubit extends Cubit<ConfirmPasswordSecureState> {
  ConfirmPasswordSecureCubit() : super(ConfirmPasswordIntial());
  bool secure = false;

  void secureTextPassword() {
    emit(ConfirmPasswordIntial());
  }

  void unsecureTextPassword() {
    emit(ConfirmPasswordVisible());
  }
}

class PasswordSecureAtLoginCubit extends Cubit<PasswordSecureAtLoginState> {
  PasswordSecureAtLoginCubit() : super(PasswordIntialAtLogin());

  void secureTextPassword() {
    emit(PasswordIntialAtLogin());
  }

  void unsecureTextPassword() {
    emit(PasswordVisibleAtLogin());
  }
}
