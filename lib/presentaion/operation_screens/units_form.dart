import 'package:engineer_app/bussniss_logic/db_handel_bloc/bloc/unit_bloc.dart';
import 'package:engineer_app/bussniss_logic/db_handel_bloc/users/bloc/user_bloc.dart';
import 'package:engineer_app/constants/colors/colors.dart';
import 'package:engineer_app/data/model/unit_model.dart';
import 'package:engineer_app/data/repository/repository.dart';
import 'package:engineer_app/presentaion/widgets/geo_locator.dart';
import 'package:engineer_app/presentaion/widgets/text_form_field_widget.dart';
import 'package:engineer_app/presentaion/widgets/wide_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnitForm extends StatelessWidget {
  TextEditingController customer_name_controller = TextEditingController();
  TextEditingController eng_name_controller = TextEditingController();
  TextEditingController location_description_controller =
      TextEditingController();
  TextEditingController location_address = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  UnitModel? unit_model;
  static List<UnitModel> list_of_units = [];

  UnitForm({super.key, this.unit_model});

  @override
  Widget build(BuildContext context) {
    UnitBloc unitBloc = context.read<UnitBloc>();

    if (unit_model != null) {
      customer_name_controller.text = unit_model!.customer_name!;
      eng_name_controller.text = unit_model!.eng_name!;

      location_description_controller.text = unit_model!.location_description!;
      location_address.text = unit_model!.location_address!;
    }
    print("1111111111111111111111111111111");

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
      body: BlocConsumer<UnitBloc, UnitState>(
        bloc: BlocProvider.of<UnitBloc>(context),
        listener: (context, state) {
          if (state is UnitError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return state is UnitLoading
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : SafeArea(
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
                                height:
                                    MediaQuery.of(context).size.height / 3.12,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/workers.png"))),
                              ),
                              TextFormFieldWidget(
                                hint_text: "customer name",
                                text_edting_controller:
                                    customer_name_controller,
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
                              GetLatLong(
                                address_location: location_address,
                              ),
                              TextFormFieldWidget(
                                hint_text: "location description",
                                text_edting_controller:
                                    location_description_controller,
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
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    UnitModel unit = UnitModel(
                                        ID: unit_model != null
                                            ? unit_model!.ID
                                            : null,
                                        customer_name:
                                            customer_name_controller.text,
                                        eng_name: eng_name_controller.text,
                                        location_address: location_address.text,
                                        location_description:
                                            location_description_controller
                                                .text,
                                        UID: GetRepository.UID!);
                                    if (unit_model != null) {
                                      unitBloc.add(UpdateUnit(unit));
                                      Navigator.of(context).pop();
                                    } else {
                                      unitBloc.add(
                                          InsertUnit(unit, GetRepository.UID!));
                                      Navigator.of(context).pop();
                                    }
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      )));
        },
      ),
    );
  }
}
