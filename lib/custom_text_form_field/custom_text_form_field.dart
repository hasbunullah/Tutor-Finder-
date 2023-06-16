import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class custom_text_form_field extends StatefulWidget {
  custom_text_form_field(
      {Key? key,
      required this.text,
      this.icon,
      required this.controller,
      required this.obscureText,
      required this.validate,
      this.icon2,
      this.type})
      : super(key: key);

  String text;
  dynamic icon;
  dynamic icon2;
  dynamic controller;
  bool obscureText;
  TextInputType? type;

  String? Function(String?)? validate;

  @override
  State<custom_text_form_field> createState() => _custom_text_form_fieldState();
}

class _custom_text_form_fieldState extends State<custom_text_form_field> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formKey,
      child: TextFormField(
        keyboardType: widget.type,
        validator: widget.validate,
        // validator: widget.validate,
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.w,
                color: Color(0xff82CD47),
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
            hintText: widget.text,
            hintStyle: TextStyle(color: Color(0xff000000).withOpacity(0.3)),
            suffixIcon: widget.icon,
            prefixIcon: widget.icon2),
      ),
    );
  }
}
