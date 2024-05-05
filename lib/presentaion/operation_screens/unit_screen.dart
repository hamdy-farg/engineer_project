import 'package:engneers_app/bussniss_logic/cubit/searching_cubit.dart';
import 'package:engneers_app/constants/colors/colors.dart';
import 'package:engneers_app/constants/diamentions/diamentions.dart';
import 'package:engneers_app/data/model/unit_model.dart';
import 'package:engneers_app/data/repository/repository.dart';
import 'package:engneers_app/presentaion/operation_screens/units_form.dart';
import 'package:engneers_app/presentaion/widgets/operations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddUnitScreen extends StatelessWidget {
  AddUnitScreen({super.key});
  List<UnitModel> unit_list = [];
  TextEditingController _SearchTextController = TextEditingController();
  bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
    unit_list = GetRepository().getUnits();
    Daimentions _daimentions = Daimentions(context: context);
    final searchingCubit = BlocProvider.of<SearchingCubit>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: BlocBuilder<SearchingCubit, SearchingState>(
          builder: (context, state) {
            if (state is SearchingNow) {
              _isSearching = true;
            } else {
              _isSearching = false;
              _SearchTextController.clear();
            }
            return AppBar(
              backgroundColor: Colors.white,
              title: _isSearching
                  ? Operations.buildSearchField(_SearchTextController)
                  : Operations.buildAppBarTitle(),
              actions: Operations.buildAppBarActions(
                  context, _isSearching, searchingCubit, state),
              leading: _isSearching
                  ? IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 25.sp,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.black,
                    )
                  : Container(),
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height /
                1.1470588235294117647058823529412,
            child: ListView.builder(
              itemCount: unit_list.length,
              itemBuilder: (conetxt, index) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                      vertical: _daimentions.Height5,
                      horizontal: _daimentions.Width5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: .5,
                          blurRadius: .5,
                          offset: Offset(0, .1), // changes position of shadow
                        ),
                      ]),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.of(context).pushNamed("/AddItemScreen");
                      },
                      onLongPress: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: _daimentions.Width5,
                            vertical: _daimentions.Height10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "customer  :${unit_list[index].customer_name}"),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => UnitForm(
                                                unit_model: unit_list[index])));
                                  },
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: _daimentions.Height5,
                            ),
                            Text(
                                "description :${unit_list[index].description}"),
                            SizedBox(
                              height: _daimentions.Height5,
                            ),
                            Text("engineer :${unit_list[index].engineer_name}")
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/UnitFormScreen");
        },
        backgroundColor: MyColors.primary_color,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30.sp,
        ),
      ),
    );
  }
}

class HH {
  BuildContext context;
  HH({required this.context});
  late double e = MediaQuery.of(context).size.height;
}
