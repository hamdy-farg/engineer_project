import 'package:engneers_app/constants/string/screens_name.dart';
import 'package:engneers_app/presentaion/auth_screens/login_screen.dart';
import 'package:engneers_app/presentaion/auth_screens/reset_password_screen.dart';
import 'package:engneers_app/presentaion/auth_screens/sign_up_screen.dart';
import 'package:engneers_app/presentaion/auth_screens/type_phone_for_reset_password.dart';
import 'package:engneers_app/presentaion/operation_screens/item_operations/item_screen.dart';
import 'package:engneers_app/presentaion/operation_screens/item_operations/items_form.dart';
import 'package:engneers_app/presentaion/operation_screens/unit_screen.dart';
import 'package:engneers_app/presentaion/operation_screens/units_form.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Screens.LoginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Screens.SignUpScreen:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case Screens.RequistPhoneNumberForResetPassowrdScreen:
        return MaterialPageRoute(builder: (_) => RequistPhoneNumberToCheck());
      case Screens.ResetPasswordScreen:
        return MaterialPageRoute(builder: (_) => ResetPassword());
      case Screens.AddUnitScreen:
        return MaterialPageRoute(builder: (_) => AddUnitScreen());
      case Screens.UnitFormScreen:
        return MaterialPageRoute(builder: (_) => UnitForm());
      case Screens.AddItemScreen:
        return MaterialPageRoute(builder: (_) => AddItemScreen());
      case Screens.ItemFormScreen:
        return MaterialPageRoute(builder: (_) => ItemFormScreen());
    }
  }
}
