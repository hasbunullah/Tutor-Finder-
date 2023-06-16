import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class custom_button extends StatelessWidget {
  custom_button({Key? key, required this.text}) : super(key: key);

  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 284.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Color(0xff82CD47)),
      child: Center(
          child: Text(
            text,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24.sp),
          )),
    );
  }
}
