part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

// to sign in :::::
class LoadUser extends UserEvent {
  final String phone_number;
  final String? password;
  LoadUser({this.password, required this.phone_number});
}

// usr singout
class SingOut extends UserEvent {}

// to register ::::
class InsertUser extends UserEvent {
  final UserModel user;
  InsertUser(this.user);
}

// change  password and phone number
class UpdateUser extends UserEvent {
  final UserModel user;
  UpdateUser(this.user);
}

// delete acount ::::
class DeleteUser extends UserEvent {
  final int? id;
  DeleteUser(this.id);
}
