import 'package:engineer_app/bussniss_logic/cubit/searching_cubit.dart';
import 'package:engineer_app/constants/colors/colors.dart';
import 'package:engineer_app/constants/diamentions/diamentions.dart';
import 'package:engineer_app/data/model/invoise_model.dart';
import 'package:engineer_app/pdf_converter/PdfPreviewPage.dart';
import 'package:engineer_app/presentaion/widgets/operations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddItemScreen extends StatelessWidget {
  AddItemScreen({super.key});
  List unit_list = [];
  TextEditingController _SearchTextController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
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
            child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (MediaQuery.of(context).size.height / 5.2) /
                      (MediaQuery.of(context).size.height / 4.0625),
                  mainAxisSpacing: 10),
              itemCount: 10,
              itemBuilder: (conetxt, index) {
                return Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: _daimentions.Height5),
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
                      onLongPress: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: _daimentions.Width5,
                            vertical: _daimentions.Height5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Jane Doe"),
                                TextButton(
                                  onPressed: () {},
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
                                "3 NewbridgeCourt chino hills , CA 91709, United States "),
                            SizedBox(
                              height: _daimentions.Height5,
                            ),
                            Text("address of your location")
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PdfPreviewPage(
                    invoice: Invoice(
                        'David Thomas',
                        '123 Fake St\r\nBermuda Triangle',
                        LineItem(
                            Nr: 01,
                            Code: 'W01',
                            Photo: 'images\preview.jpg',
                            Category: 'Category',
                            Note: 'Note',
                            Width: 100,
                            Height: 20,
                            Position: 'Kitchen',
                            AreamM2: 10),
                        'Unit Name'),
                  ),
                ),
              );
              // rootBundle.
            },
            child: Icon(Icons.picture_as_pdf),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/ItemFormScreen");
            },
            backgroundColor: MyColors.primary_color,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30.sp,
            ),
          ),
        ],
      ),
    );
  }
}
