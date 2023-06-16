import 'package:fluttertoast/fluttertoast.dart';

import 'color_constant.dart';

class ToastMessage{
  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
      backgroundColor: blackColor,
    );
  }
}