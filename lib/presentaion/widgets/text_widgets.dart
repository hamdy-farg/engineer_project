import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MeduimText extends StatelessWidget {
  final String text;
  final Color color;
  final double? size;

  const MeduimText({
    this.size = null,
    Key? key,
    this.color = Colors.white,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size == null ? 18.sp : size,
          color: color),
    );
  }
}

class BigText extends StatelessWidget {
  final String text;

  const BigText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
    );
  }
}
