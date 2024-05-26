// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:engineer_app/bussniss_logic/cubit/area_cubit/cubit/area_cubit.dart';
import 'package:engineer_app/bussniss_logic/cubit/password_secure_cubit.dart';
import 'package:engineer_app/bussniss_logic/cubit/searching_cubit.dart';
import 'package:engineer_app/bussniss_logic/db_handel_bloc/bloc/unit_bloc.dart';
import 'package:engineer_app/bussniss_logic/db_handel_bloc/users/bloc/user_bloc.dart';
import 'package:engineer_app/constants/string/screens_name.dart';
import 'package:engineer_app/data/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engineer_app/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  int? isLogin;

  WidgetsFlutterBinding.ensureInitialized();
  await GetRepository().check();
  runApp(NileApp(
    appRouter: AppRouter(),
    isLogin: isLogin,
  ));
}

class NileApp extends StatefulWidget {
  final AppRouter? appRouter;
  static int? save;
  int? isLogin;

  NileApp({
    Key? key,
    required this.isLogin,
    this.appRouter,
  });
  @override
  State<NileApp> createState() => _NileAppState();
}

class _NileAppState extends State<NileApp> {
  @override
  Widget build(BuildContext context) {
    print("ddddddddddddd");

    NileApp.save = GetRepository.UID;
    print("${NileApp.save} ------------)))--------");

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
          ),
          BlocProvider(
            create: (context) => UnitBloc(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: NileApp.save == null
              ? Screens.LoginScreen
              : Screens.AddUnitScreen,
          onGenerateRoute: widget.appRouter!.generateRoute,
        ),
      ),
    );
  }
}
