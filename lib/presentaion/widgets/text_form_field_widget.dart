import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hint_text;
  final String? Function(String?)? validator;
  final TextEditingController? text_edting_controller;
  final bool secure;
  final IconButton? suffixIcon;
  final TextInputType? keybourdType;
  final int? max_line;
  final TextDirection text_direction;
  final bool read_only;
  final bool sizedBox;
  const TextFormFieldWidget(
      {Key? key,
      this.sizedBox = true,
      this.text_direction = TextDirection.ltr,
      this.max_line = 1,
      this.keybourdType = null,
      required this.hint_text,
      this.read_only = false,
      this.validator,
      this.text_edting_controller = null,
      this.suffixIcon = null,
      this.secure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          textDirection: text_direction,
          maxLines: max_line,
          readOnly:  read_only,
          keyboardType: keybourdType,
          obscureText: secure,
          controller: text_edting_controller,
          validator: validator,
          decoration: InputDecoration(
            
            suffixIcon: suffixIcon,
            hintText: "$hint_text",
            labelStyle: TextStyle(color: Colors.black),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 180, 178, 178), width: 1),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          cursorColor: Colors.black,
        ),
        sizedBox
            ? SizedBox(
                height: (MediaQuery.of(context).size.height) / 37,
              )
            : Container(),
      ],
    );
  }
}
