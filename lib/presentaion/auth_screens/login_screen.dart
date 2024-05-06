import 'package:engneers_app/bussniss_logic/cubit/password_secure_cubit.dart';
import 'package:engneers_app/bussniss_logic/db_handel_bloc/users/bloc/user_bloc.dart';
import 'package:engneers_app/constants/diamentions/diamentions.dart';
import 'package:engneers_app/data/repository/repository.dart';
import 'package:engneers_app/presentaion/auth_screens/sign_up_screen.dart';
import 'package:engneers_app/presentaion/widgets/text_form_field_widget.dart';
import 'package:engneers_app/presentaion/widgets/wide_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/user_model.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController password_controller = TextEditingController();
  TextEditingController phone_number_controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool islouding = false;
  @override
  Widget build(BuildContext context) {
    // to get list of user is stored in repo

    // to get diamentions of screen with medaiquiry
    Daimentions _daimentions = Daimentions(context: context);

    final passwordSecureCubit =
        BlocProvider.of<PasswordSecureAtLoginCubit>(context);
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoaded) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/AddUnitScreen", (route) => false);
          } else if (state is UserError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          // TODO: implement listener
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return state is UserLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: _daimentions.Width20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 3.9,
                                width: MediaQuery.of(context).size.width / 1.8,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/company_logo.png"),
                                  ),
                                ),
                              ),
                            ),

                            /// Text Form Field for phone number
                            TextFormFieldWidget(
                              hint_text: "Phone Number",
                              text_edting_controller: phone_number_controller,
                              keybourdType: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("this field cannot be empty");
                                }
                              },
                            ),

                            /// Text Form Field for password provided by cubit (PasswordSecureAtLoginCubit)
                            BlocBuilder<PasswordSecureAtLoginCubit,
                                    PasswordSecureAtLoginState>(
                                builder: (context, state) {
                              return TextFormFieldWidget(
                                keybourdType: TextInputType.visiblePassword,
                                text_edting_controller: password_controller,
                                hint_text: "Password",
                                secure: (state is PasswordVisibleAtLogin)
                                    ? true
                                    : false,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if (state is PasswordVisibleAtLogin)
                                      passwordSecureCubit.secureTextPassword();
                                    else {
                                      passwordSecureCubit
                                          .unsecureTextPassword();
                                    }
                                  },
                                  icon: Icon((state is PasswordVisibleAtLogin)
                                      ? Icons.remove_red_eye
                                      : Icons.remove_red_eye_outlined),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("this field cannot be empty");
                                  }
                                },
                              );
                            }),
                            Container(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      "/RequistPhoneNumberForResetPassowrd");
                                },
                                child: Text(
                                  "Forget Password?",
                                  style: TextStyle(color: Colors.blue.shade400),
                                ),
                              ),
                            ),
                            WidButton(
                              text: "Login",
                              color: const Color.fromRGBO(66, 119, 253, 1),
                              splashColor: Colors.blue.shade400,
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  UserBloc userBloc =
                                      BlocProvider.of<UserBloc>(context);
                                  userBloc.add(LoadUser(
                                      password: password_controller.text,
                                      phone_number:
                                          phone_number_controller.text));
                                }
                              },
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Don't have an account?",
                                  style: TextStyle(color: Colors.grey)),
                              TextSpan(
                                  text: "Register Now",
                                  style: TextStyle(color: Colors.blue.shade400),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .pushNamed("/signUp");
                                    })
                            ]))
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    ));
  }
}
