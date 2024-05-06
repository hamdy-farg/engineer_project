import 'package:bloc/bloc.dart';
import 'package:engneers_app/data/model/user_model.dart';
import 'package:engneers_app/db/sqldb.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    // sign up for new user ::::::
    on<InsertUser>((event, emit) async {
      emit(UserLoading());
      try {
        if (await SqlDb().insertUser(event.user) == 0) {
          emit(UserError(message: "user is exists before"));
        } else {
          emit(UserInitial());
        }
      } catch (e) {
        emit(UserError(message: e.toString()));
      }
    });

    on<LoadUser>((event, emit) async {
      emit(UserLoading());
      try {
        final UserModel? users =
            await SqlDb().getUsers(event.password, event.phone_number);
        if (users!.full_name == "0") {

          emit(
            UserError(
              message: "your phone or password is wrong",
            ),
          );
        } else {
          emit(UserLoaded(users!));
        }
      } catch (e) {
        emit(
          UserError(
            message: e.toString(),
          ),
        );
      }
    });

    on<UpdateUser>((event, emit) async {
      emit(UserLoading());
      try {
        final UserModel? users =
            await SqlDb().getUsers(null, event.phone_number);
        if (users!.full_name == "0") {
          UserError(
            message: "your phone  is wrong",
          );
        } else {
          await SqlDb().updateUser(users!);
          emit(userExists(users));
        }
      } catch (e) {
        emit(UserError(message: e.toString()));
      }
    });

    on<SingOut>((event, emit) async {
      emit(UserLoading());
      try {
        emit(UserInitial());
      } catch (e) {
        emit(UserError(message: e.toString()));
      }
    });
  }
}
