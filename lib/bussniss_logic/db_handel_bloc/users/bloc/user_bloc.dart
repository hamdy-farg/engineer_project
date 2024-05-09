import 'package:bloc/bloc.dart';
import 'package:engineer_app/data/model/user_model.dart';
import 'package:engineer_app/db/sqldb.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    // sign up for new user ::::::
    on<InsertUser>((event, emit) async {
      emit(UserLoading());
      try {
        if (await InsertData().insertUser(event.user) == 0) {
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
            await GetData().getUsers(event.password, event.phone_number);
        // to retrieve user from database

        // we pass password as null to reset it by phone number
        if (event.password == null) {
          // if user doesnot exit the full name is 0 i initailize it
          if (users?.full_name == "0") {
            emit(
              UserError(
                message: "your phone does not exist",
              ),
            );
          } else {
            // the user is exists and i can retrieve it
            emit(userExists(users!));
          }
        } else {
          // when i ask to load user with phone and password
          if (users?.full_name == "0") {
            emit(
              UserError(
                message: "your phone or password  is wrong",
              ),
            );
          } else {
            emit(UserLoaded(users!));
          }
        }
      } catch (e) {
        emit(
          UserError(
            message: "e.toString()",
          ),
        );
      }
    });

    on<UpdateUser>((event, emit) async {
      emit(UserLoading());
      try {
        if (await UpdataData().updateUser(event.user) == 0) {
          emit(UserError(message: "field to get user"));
        } else {
          print((await UpdataData().updateUser(event.user) == 0));
          emit(UserInitial());
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
