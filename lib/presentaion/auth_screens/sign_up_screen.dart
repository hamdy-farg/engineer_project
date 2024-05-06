// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:engneers_app/bussniss_logic/cubit/password_secure_cubit.dart';
import 'package:engneers_app/bussniss_logic/db_handel_bloc/users/bloc/user_bloc.dart';
import 'package:engneers_app/constants/colors/colors.dart';
import 'package:engneers_app/constants/diamentions/diamentions.dart';
import 'package:engneers_app/data/repository/repository.dart';
import 'package:engneers_app/presentaion/widgets/text_form_field_widget.dart';
import 'package:engneers_app/presentaion/widgets/text_widgets.dart';
import 'package:engneers_app/presentaion/widgets/wide_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/user_model.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  TextEditingController full_name_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController confirm_password_controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  List<UserModel> users = [];
  @override
  Widget build(BuildContext context) {
    final passwordSecureCubit = BlocProvider.of<PasswordSecureCubit>(context);
    final confirmpasswordSecureCubit =
        BlocProvider.of<ConfirmPasswordSecureCubit>(context);
    Daimentions _daimentions = Daimentions(context: context);

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
        body: BlocListener<UserBloc, UserState>(listener: (context, state) {
          if (state is UserInitial) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("successfully created")));
            Navigator.of(context).pop();
          } else if (state is UserError) {
            Navigator.of(context).pop();

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is UserLoading) {}
        }, child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return state is UserLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: _daimentions.Width20,
                      ),
                      child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 26,
                              ),
                              // big Text for title
                              BigText(
                                text: "Register to Nile",
                              ),

                              //SizedBox to make space between
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 78,
                              ),

                              //Text Form Field For fullname
                              TextFormFieldWidget(
                                text_edting_controller: full_name_controller,
                                hint_text: "Full Name",
                                keybourdType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Full name cannot be empty");
                                  }
                                  if (value.length < 6) {
                                    return ("Full name cannot be less than 6 character");
                                  }
                                  if (value
                                      .toString()
                                      .contains(RegExp('r[0:9]'), 3)) {
                                    return ("Full name cannot be conatian more than 2 digits");
                                  }
                                },
                              ),

                              // Text Form Field for phone number
                              TextFormFieldWidget(
                                text_edting_controller: phone_controller,
                                hint_text: "Phone Number",
                                keybourdType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("phone number cannot be empty");
                                  } else if (value
                                      .toLowerCase()
                                      .contains(RegExp('r[a:z]'), 1)) {
                                    return ("phone number cannot contain characters");
                                  }
                                  ;
                                },
                              ),

                              // Text Form Field for password provided by cubit (PasswordSecureCubit)
                              BlocBuilder<PasswordSecureCubit,
                                  PasswordSecureState>(
                                builder: (context, state) {
                                  return TextFormFieldWidget(
                                    keybourdType: TextInputType.visiblePassword,
                                    secure: !(state is passwordVisible)
                                        ? true
                                        : false,
                                    text_edting_controller: password_controller,
                                    hint_text: " Password",
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        if (state is passwordVisible)
                                          passwordSecureCubit
                                              .secureTextPassword();
                                        else {
                                          passwordSecureCubit
                                              .unsecureTextPassword();
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
                                      ConfirmPasswordSecureState>(
                                  builder: (context, state) {
                                return TextFormFieldWidget(
                                  keybourdType: TextInputType.visiblePassword,
                                  text_edting_controller:
                                      confirm_password_controller,
                                  hint_text: "Confirm Password",
                                  secure: !(state is ConfirmPasswordVisible)
                                      ? true
                                      : false,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      if (state is ConfirmPasswordVisible)
                                        confirmpasswordSecureCubit
                                            .secureTextPassword();
                                      else {
                                        confirmpasswordSecureCubit
                                            .unsecureTextPassword();
                                      }
                                    },
                                    icon: Icon(
                                        !(state is ConfirmPasswordVisible)
                                            ? Icons.remove_red_eye
                                            : Icons.remove_red_eye_outlined),
                                  ),
                                );
                              }),

                              // Button to Register
                              WidButton(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      UserBloc userBloc =
                                          context.read<UserBloc>();

                                      UserModel user = UserModel(
                                          full_name: full_name_controller.text,
                                          phone_number: phone_controller.text,
                                          password: password_controller.text);
                                      userBloc.add(InsertUser(user));
                                    }
                                  },
                                  text: "Register",
                                  color: MyColors.primary_color,
                                  splashColor: MyColors.Splash_color),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          },
        )));
  }
}
