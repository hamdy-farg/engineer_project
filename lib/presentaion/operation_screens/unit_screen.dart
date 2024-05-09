import 'package:engineer_app/bussniss_logic/cubit/searching_cubit.dart';
import 'package:engineer_app/bussniss_logic/db_handel_bloc/bloc/unit_bloc.dart';
import 'package:engineer_app/constants/colors/colors.dart';
import 'package:engineer_app/constants/diamentions/diamentions.dart';
import 'package:engineer_app/data/repository/repository.dart';
import 'package:engineer_app/presentaion/operation_screens/units_form.dart';
import 'package:engineer_app/presentaion/widgets/operations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddUnitScreen extends StatelessWidget {
  AddUnitScreen({super.key});
  TextEditingController _SearchTextController = TextEditingController();
  bool _isSearching = false;
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    // to check user is retrieve from sharedprefs
    int user;
    GetRepository().check();

    // to get userID from repo
    user = GetRepository.UID!;

    // to repiar diamention of the page
    Daimentions _daimentions = Daimentions(context: context);

    // to use searchingCubit
    final searchingCubit = BlocProvider.of<SearchingCubit>(context);

    //  to Use UnitBloc
    UnitBloc unitBloc = context.read<UnitBloc>();

    // the event to load Units of the user by his UID
    unitBloc.add(
      LoadAllUnits(UID: user),
    );

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
                      onPressed: () async {},
                      color: Colors.black,
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 25.sp,
                      ),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('LogedBefore');

                        print(" loogggggggggggggggggggg");

                        Navigator.of(context).popAndPushNamed("/login");

                        print(
                            "بنمممممممممممممممممممممممممممممممممممووووووووووووووت");
                      },
                      color: Colors.black,
                    ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<UnitBloc, UnitState>(
          bloc: BlocProvider.of<UnitBloc>(context),
          listener: (context, state) async {
            if (state is UnitError) {
              counter++;
              if (counter == 1) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            }

            // TODO: implement listener
          },
          builder: (context, state) {
            return (state is LoadAllUnits)
                ? Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : (state is AllUnitsLoaded)
                    ? SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          height: MediaQuery.of(context).size.height /
                              1.1470588235294117647058823529412,
                          child: ListView.builder(
                            itemCount: state.Units.length,
                            itemBuilder: (conetxt, index) {
                              print(state);
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
                                        offset: Offset(0,
                                            .1), // changes position of shadow
                                      ),
                                    ]),
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed("/AddItemScreen");
                                    },
                                    onLongPress: () async {
                                      // to remove the user from shared memory
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: _daimentions.Width5,
                                          vertical: _daimentions.Height10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "customer : ${state.Units[index].customer_name}"),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UnitForm(
                                                                unit_model:
                                                                    state.Units[
                                                                        index],
                                                              )));
                                                },
                                                child: Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: _daimentions.Height5,
                                          ),
                                          Text(
                                              "description : ${state.Units[index].location_description}}"),
                                          SizedBox(
                                            height: _daimentions.Height5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "engineer :  ${state.Units[index].eng_name}",
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    unitBloc.add(DeleteUnit(
                                                        id: state
                                                            .Units[index].ID,
                                                        UID: state
                                                            .Units[index].UID));
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Color.fromARGB(
                                                        255, 255, 17, 0),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Container();
          },
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

// FloatingActionButton(
//   onPressed: () async {
//     // to add SignOut

//   },
//   backgroundColor: Colors.red,
//   child: Icon(
//     Icons.add,
//     color: Colors.white,
//     size: 30.sp,
//   ),
// ),
