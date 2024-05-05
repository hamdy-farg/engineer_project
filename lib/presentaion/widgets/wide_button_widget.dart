import 'package:engneers_app/presentaion/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class WidButton extends StatelessWidget {
  final String text;
  void Function()? onTap;
  final Color color;
  final Color splashColor;
  double width;
  WidButton({
    this.width = double.infinity,
    Key? key,
    this.onTap,
    required this.text,
    required this.color,
    required this.splashColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 78),
      height: MediaQuery.of(context).size.height / 17.3,
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: color,
        child: InkWell(
          
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          splashColor: splashColor,
          child: Center(
            child: MeduimText(text: "$text"),
          ),
        ),
      ),
    );
  }
}
