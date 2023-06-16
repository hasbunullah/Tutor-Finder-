import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tutor_finder/custom_button/custom_button.dart';
import 'package:tutor_finder/custom_text_form_field/custom_text_form_field.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);

  dynamic controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.green.withOpacity(0.3),
                    Colors.white,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          backgroundColor: Colors.green.withOpacity(0.5),
          title: Text('Forget Password'),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.green.withOpacity(0.8),
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.green.withOpacity(0.8),
                  ])
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                custom_text_form_field(
                  validate: MultiValidator([
                    EmailValidator(errorText: 'Enter a valid email address'),
                  ]),
                  obscureText: false,
                  text: 'Enter User Email',
                  controller: controller,
                ),
                SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  child: custom_button(text: 'Submit'),
                  onTap: () {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: controller.text.toString())
                        .then((value) => {
                              Get.snackbar(
                                "Email Request",
                                "We have send you email Please Check",
                                snackPosition: SnackPosition.TOP,
                                colorText: Colors.green,
                                borderRadius: 10,

                              ),
                            }).onError((error, stackTrace) => {
                      Get.snackbar(
                        "Bad Email Formation",
                        "Email is not formated well",
                        snackPosition: SnackPosition.TOP,
                        colorText: Colors.red,
                        borderRadius: 10,
                      ),
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
