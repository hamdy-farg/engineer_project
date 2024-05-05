import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequisted>((event, emit) async {
      try {
        final phone = event.phone;
        final password = event.password;

        if (phone.length < 1) {
          return emit(
              AuthFailure(error_message: 'phone number cannot be less than 6'));
        }

        await Future.delayed(Duration(seconds: 1), () {
          return emit(AuthSucccess(uid: "$phone-- $phone"));
        });
      } catch (e) {
        return emit(AuthFailure(error_message: e.toString()));
      }
      // TODO: implement event handler
    });
  }
}
