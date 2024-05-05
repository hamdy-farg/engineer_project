import 'package:engneers_app/constants/colors/colors.dart';
import 'package:engneers_app/constants/diamentions/diamentions.dart';
import 'package:engneers_app/data/model/item_model.dart';
import 'package:engneers_app/data/model/unit_model.dart';
import 'package:engneers_app/presentaion/widgets/text_form_field_widget.dart';
import 'package:engneers_app/presentaion/widgets/wide_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../data/api/geo_locator.dart';

class UnitForm extends StatelessWidget {
  TextEditingController customer_name_controller = TextEditingController();
  TextEditingController eng_name_controller = TextEditingController();
  TextEditingController location_description_controller =
      TextEditingController();
  UnitModel? unit_model;
  static List<UnitModel> list_of_units = [];

  UnitForm({super.key, this.unit_model});

  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    if (unit_model != null) {
      customer_name_controller.text = unit_model!.customer_name;
      eng_name_controller.text = unit_model!.engineer_name;

      location_description_controller.text = unit_model!.description;
    }
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
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.44,
                  height: MediaQuery.of(context).size.height / 3.12,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/workers.png"))),
                ),
                TextFormFieldWidget(
                  hint_text: "customer name",
                  text_edting_controller: customer_name_controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "can not be empty";
                    }
                  },
                ),
                TextFormFieldWidget(
                  hint_text: "engineer name",
                  text_edting_controller: eng_name_controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "can not be empty";
                    }
                  },
                ),
                GetLatLong(),
                TextFormFieldWidget(
                  hint_text: "location description",
                  text_edting_controller: location_description_controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "can not be empty";
                    }
                  },
                  max_line: 4,
                ),
                WidButton(
                  text: "Enter",
                  color: MyColors.primary_color,
                  splashColor: MyColors.Splash_color,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      String id = Uuid().v1();
                      list_of_units.add(UnitModel(
                          ID: id,
                          customer_name: customer_name_controller.text,
                          engineer_name: eng_name_controller.text,
                          location: "",
                          description: location_description_controller.text));
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
