// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:engneers_app/bussniss_logic/auth_bloc/bloc/auth_bloc.dart';
import 'package:engneers_app/bussniss_logic/cubit/area_cubit/cubit/area_cubit.dart';
import 'package:engneers_app/bussniss_logic/cubit/password_secure_cubit.dart';
import 'package:engneers_app/bussniss_logic/cubit/searching_cubit.dart';
import 'package:engneers_app/bussniss_logic/db_handel_bloc/users/bloc/user_bloc.dart';
import 'package:engneers_app/db/sqldb.dart';
import 'package:engneers_app/presentaion/auth_screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engneers_app/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(NileApp(
    appRouter: AppRouter(),
  ));
}

class NileApp extends StatelessWidget {
  final AppRouter appRouter;
  const NileApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SqlDb db = SqlDb();
    print(db.db);
    return ScreenUtilInit(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PasswordSecureCubit(),
          ),
          BlocProvider(
            create: (context) => SearchingCubit(),
          ),
          BlocProvider(
            create: (context) => PasswordSecureAtLoginCubit(),
          ),
          BlocProvider(
            create: (context) => ConfirmPasswordSecureCubit(),
          ),
          BlocProvider(
            create: (context) => AreaCubit(),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => UserBloc(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          onGenerateRoute: appRouter.generateRoute,
        ),
      ),
    );
  }
}
