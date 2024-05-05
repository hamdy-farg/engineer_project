
import 'package:engneers_app/bussniss_logic/cubit/searching_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Operations {
  static Widget buildSearchField(TextEditingController searchTextController) {
    return TextField(
      controller: searchTextController,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          hintText: "find A Unit ....",
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 18.sp)),
      style: TextStyle(),
      onChanged: (searchedCharacter) {},
    );
  }

  static Widget buildAppBarTitle() {
    return Text(
      "you can add Units here",
      style: TextStyle(
        color: Colors.black,
      ),
    );
  }

  static List<Widget> buildAppBarActions(BuildContext context,
      bool _isSearching, SearchingCubit searchingCubit, SearchingState state) {
    if (state is SearchingNow) {
      _isSearching = true;
    } else {
      _isSearching = false;
    }
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              searchingCubit.returnToInitial();
            },
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: () {
              _startSearch(context, searchingCubit);
            },
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ))
      ];
    }
  }

  static void _startSearch(
      BuildContext context, SearchingCubit searchingCubit) {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry());
    searchingCubit.goToSearching();
  }
}
