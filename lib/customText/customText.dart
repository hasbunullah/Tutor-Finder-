import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class customText extends StatelessWidget {
   customText({Key? key, required this.text}) : super(key: key);

  String text;

  @override
  Widget build(BuildContext context) {
    return Text( text,
        style: TextStyle(
            color: Color(0xff000000).withOpacity(0.5),
            fontSize: 20.sp,
            decoration: TextDecoration.none));
  }
}
