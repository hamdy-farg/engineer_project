import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownMenu extends StatefulWidget {
  List<String> list;
  DropDownMenu({super.key, required this.list});

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = widget.list.first;

    return DropdownMenu<String>(
      width: 300,
      inputDecorationTheme: InputDecorationTheme(),
      textStyle: TextStyle(
        fontSize: 15.sp,
      ),
      menuStyle: MenuStyle(),
      initialSelection: widget.list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries:
          widget.list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
