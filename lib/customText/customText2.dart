import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class customText2 extends StatelessWidget {
   customText2({Key? key, required this.text}) : super(key: key);

   String text;

    @override
    Widget build(BuildContext context) {
      return Text( text,
          style: TextStyle(
              color: Color(0xff000000),
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none));

  }
}
