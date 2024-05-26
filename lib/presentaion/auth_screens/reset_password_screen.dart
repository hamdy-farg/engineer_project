import 'package:engineer_app/bussniss_logic/cubit/password_secure_cubit.dart';
import 'package:engineer_app/bussniss_logic/db_handel_bloc/users/bloc/user_bloc.dart';
import 'package:engineer_app/constants/colors/colors.dart';
import 'package:engineer_app/constants/diamentions/diamentions.dart';
import 'package:engineer_app/constants/string/screens_name.dart';
import 'package:engineer_app/presentaion/operation_screens/item_operations/item_screen.dart';
import 'package:engineer_app/presentaion/widgets/text_form_field_widget.dart';
import 'package:engineer_app/presentaion/widgets/text_widgets.dart';
import 'package:engineer_app/presentaion/widgets/wide_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  TextEditingController password_controller = TextEditingController();
  TextEditingController confirm_password_controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final passwordSecureCubit = BlocProvider.of<PasswordSecureCubit>(context);
    final confirmpasswordSecureCubit =
        BlocProvider.of<ConfirmPasswordSecureCubit>(context);
    Daimentions _daimentions = Daimentions(context: context);
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    print(userBloc.state);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30.sp,
          ),
          onPressed: () {
            confirmpasswordSecureCubit.secureTextPassword();
            passwordSecureCubit.secureTextPassword();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is UserInitial) {
            // to go to login page
            Navigator.pushNamedAndRemoveUntil(
                context, Screens.LoginScreen, (route) => false);

            // to show snackbar
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("you succesfully changed your password")));
          }
          // TODO: implement listener
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: _daimentions.Width20),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: _daimentions.Height30,
                    ),
                    BigText(text: "Reset Password"),
                    SizedBox(
                      height: _daimentions.Height10,
                    ),
                    Text(
                      "please Enter Your Password And Confirm The Password",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: _daimentions.Height10,
                    ),
                    // Text Form Field for password provided by cubit (PasswordSecureCubit)
                    BlocBuilder<PasswordSecureCubit, PasswordSecureState>(
                      builder: (context, state) {
                        return TextFormFieldWidget(
                          keybourdType: TextInputType.visiblePassword,
                          secure: !(state is passwordVisible) ? true : false,
                          text_edting_controller: password_controller,
                          hint_text: " Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (state is passwordVisible)
                                passwordSecureCubit.secureTextPassword();
                              else {
                                passwordSecureCubit.unsecureTextPassword();
                              }
                            },
                            icon: Icon(!(state is passwordVisible)
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("confirm cannot be empty");
                            }
                            if (password_controller.text !=
                                confirm_password_controller.text) {
                              return ("confirm password doesnot match with confirm password");
                            }
                          },
                        );
                      },
                    ),

                    // Text Form Field for password provided by cubit (ConfirmPasswordSecureCubit)
                    BlocBuilder<ConfirmPasswordSecureCubit,
                        ConfirmPasswordSecureState>(builder: (context, state) {
                      return TextFormFieldWidget(
                        keybourdType: TextInputType.visiblePassword,
                        text_edting_controller: confirm_password_controller,
                        hint_text: "Confirm Password",
                        secure:
                            !(state is ConfirmPasswordVisible) ? true : false,
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (state is ConfirmPasswordVisible)
                              confirmpasswordSecureCubit.secureTextPassword();
                            else {
                              confirmpasswordSecureCubit.unsecureTextPassword();
                            }
                          },
                          icon: Icon(!(state is ConfirmPasswordVisible)
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined),
                        ),
                      );
                    }),
                    BlocBuilder<UserBloc, UserState>(
                      bloc: BlocProvider.of<UserBloc>(context),
                      builder: (context, state) {
                        return WidButton(
                            onTap: () {
                              print(userBloc.state);

                              if (formKey.currentState!.validate()) {
                                print(userBloc.state);

                                if (state is userExists) {
                                  state.user.password =
                                      password_controller.text;

                                  print(state.user.password);
                                  userBloc.add(UpdateUser(state.user));
                                } else {
                                  print("object");
                                }
                              }
                            },
                            text: "Update",
                            color: MyColors.primary_color,
                            splashColor: MyColors.Splash_color);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
