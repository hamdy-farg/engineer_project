import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Widgetss {
  Widgetss();
  Widget _buildSearchField(TextEditingController searchTextController) {
    return TextField(
      controller: searchTextController,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          hintText: "find A Unit ....",
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 18.sp)),
      style: TextStyle(),
    );
  }
}
