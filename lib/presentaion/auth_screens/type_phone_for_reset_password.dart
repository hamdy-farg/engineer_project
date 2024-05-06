import 'package:engneers_app/bussniss_logic/db_handel_bloc/users/bloc/user_bloc.dart';
import 'package:engneers_app/constants/colors/colors.dart';
import 'package:engneers_app/constants/diamentions/diamentions.dart';
import 'package:engneers_app/presentaion/auth_screens/sign_up_screen.dart';
import 'package:engneers_app/presentaion/widgets/text_form_field_widget.dart';
import 'package:engneers_app/presentaion/widgets/text_widgets.dart';
import 'package:engneers_app/presentaion/widgets/wide_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequistPhoneNumberToCheck extends StatelessWidget {
  RequistPhoneNumberToCheck({super.key});
  TextEditingController phone_controller = TextEditingController();
  GlobalKey<FormState> forKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Daimentions _daimentions = Daimentions(context: context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30.sp,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          print(state is userExists);
          if (state is userExists) {
            Navigator.of(context).pushNamed("/ResetPassword");
            state = UserInitial();
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          // TODO: implement listener
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return state is UserLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: _daimentions.Width20,
                            vertical: _daimentions.Height40),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/gifs/phone_gif.gif"))),
                              ),
                              BigText(text: "Enter phone "),
                              Text(
                                "you have to enter your phone number",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                " which you register with ",
                                style: TextStyle(color: Colors.grey),
                              ),

                              // Text Form Field for phone number
                              Form(
                                key: forKey,
                                child: TextFormFieldWidget(
                                  text_edting_controller: phone_controller,
                                  hint_text: "Phone Number",
                                  keybourdType: TextInputType.phone,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("phone number cannot be empty");
                                    }
                                  },
                                ),
                              ),

                              WidButton(
                                  onTap: () {
                                    if (forKey.currentState!.validate()) {
                                      UserBloc userBloc =
                                          BlocProvider.of<UserBloc>(context);
                                      userBloc.add(
                                          UpdateUser(phone_controller.text));
                                    }
                                  },
                                  text: "check",
                                  color: MyColors.primary_color,
                                  splashColor: MyColors.Splash_color),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
