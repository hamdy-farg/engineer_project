import 'package:engineer_app/bussniss_logic/cubit/area_cubit/cubit/area_cubit.dart';
import 'package:engineer_app/constants/colors/colors.dart';
import 'package:engineer_app/constants/diamentions/diamentions.dart';
import 'package:engineer_app/data/model/item_model.dart';
import 'package:engineer_app/presentaion/operation_screens/item_operations/item_widgets/simple_dialog.dart';
import 'package:engineer_app/presentaion/widgets/text_form_field_widget.dart';
import 'package:engineer_app/presentaion/widgets/text_widgets.dart';
import 'package:engineer_app/presentaion/widgets/wide_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'item_widgets/drop_down_menu.dart';

class ItemFormScreen extends StatelessWidget {
  ItemFormScreen({super.key});
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormState> formKey_for_height_and_width = GlobalKey();

  TextEditingController project_description_controller =
      TextEditingController();
  TextEditingController item_description_controller = TextEditingController();
  TextEditingController height_controller = TextEditingController();
  TextEditingController width_controller = TextEditingController();
  TextEditingController item_position = TextEditingController();
  double area = 0;

  @override
  Widget build(BuildContext context) {
    Daimentions _daimentions = Daimentions(context: context);
    AreaCubit areaCubit = BlocProvider.of<AreaCubit>(context);
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _daimentions.Width10,
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3.9,
                        width: MediaQuery.of(context).size.width / 1.8,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/images/add_item.png"),
                        )),
                      ),
                      TextFormFieldWidget(
                        max_line: 4,
                        hint_text: "project description",
                        text_edting_controller: project_description_controller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("field cannot be empty");
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ImageContainer(),
                          ImageContainer(),
                        ],
                      ),
                      SizedBox(
                        height: _daimentions.Height10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ImageContainer(),
                          ImageContainer(),
                        ],
                      ),
                      SizedBox(
                        height: _daimentions.Height20,
                      ),
                      Form(
                        key: formKey_for_height_and_width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormFieldWidget(
                                keybourdType: TextInputType.number,
                                hint_text: "Height",
                                text_edting_controller: height_controller,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("field cannot be empty");
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: _daimentions.Width5,
                            ),
                            Container(
                              child: BigText(
                                text: "×",
                              ),
                            ),
                            SizedBox(
                              width: _daimentions.Width5,
                            ),
                            Expanded(
                              child: TextFormFieldWidget(
                                keybourdType: TextInputType.number,
                                hint_text: "Width",
                                text_edting_controller: width_controller,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("field cannot be empty");
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<AreaCubit, AreaState>(
                            builder: (context, state) {
                              if (state is AreaChange) {
                                area = double.parse(height_controller.text) *
                                    double.parse(width_controller.text);
                                areaCubit.areaInitial();
                              }
                              return Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1)),
                                child: MeduimText(
                                  text: "$area m\u00b2",
                                  color: Colors.black,
                                ),
                              );
                            },
                          ),
                          WidButton(
                            onTap: () {
                              if (formKey_for_height_and_width.currentState!
                                  .validate()) {
                                areaCubit.changeArea();
                              }
                            },
                            text: "calculate",
                            color: MyColors.primary_color,
                            splashColor: MyColors.Splash_color,
                            width: MediaQuery.of(context).size.width / 3.2727,
                          ),
                        ],
                      ),
                      Container(
                        child: DropDownMenu(list: ["Window UPVC", "Door UPVC"]),
                      ),
                      SizedBox(
                        height: _daimentions.Height20,
                      ),
                      TextFormFieldWidget(
                        hint_text: "Position of the item",
                        text_edting_controller: item_position,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("field cannot be empty");
                          }
                        },
                      ),
                      WidButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("added successfuly"),
                                ),
                              );
                            }
                          },
                          text: "Add Item",
                          color: MyColors.primary_color,
                          splashColor: MyColors.Splash_color)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
