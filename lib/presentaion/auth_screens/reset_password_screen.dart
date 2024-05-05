import 'package:engneers_app/bussniss_logic/cubit/password_secure_cubit.dart';
import 'package:engneers_app/constants/colors/colors.dart';
import 'package:engneers_app/constants/diamentions/diamentions.dart';
import 'package:engneers_app/presentaion/auth_screens/sign_up_screen.dart';
import 'package:engneers_app/presentaion/widgets/text_form_field_widget.dart';
import 'package:engneers_app/presentaion/widgets/text_widgets.dart';
import 'package:engneers_app/presentaion/widgets/wide_button_widget.dart';
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
      body: SafeArea(
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
                      secure: !(state is ConfirmPasswordVisible) ? true : false,
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
                  WidButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("successfully created")));
                          Navigator.pop(context);
                        }
                      },
                      text: "Update",
                      color: MyColors.primary_color,
                      splashColor: MyColors.Splash_color),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
