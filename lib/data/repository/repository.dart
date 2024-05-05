import 'package:engneers_app/data/model/user_model.dart';
import 'package:engneers_app/presentaion/operation_screens/item_operations/items_form.dart';
import 'package:engneers_app/presentaion/operation_screens/units_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetRepository {
  getUnits() {
    return UnitForm.list_of_units;
  }

  GetUser() {
    return SetRepository().getUser();
  }
}

class SetRepository {
  static List<User> _users = [];

  setUser(String full_name, String phone_number, String password) {
    _users.add(User(
      full_name: full_name,
      phone_number: phone_number,
      password: password,
    ));
  }

  getUser() {
    return _users;
  }
}
