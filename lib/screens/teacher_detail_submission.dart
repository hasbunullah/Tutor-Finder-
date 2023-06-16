import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tutor_finder/customText/customText.dart';
import 'package:tutor_finder/custom_button/custom_button.dart';
import 'package:tutor_finder/custom_text_form_field/custom_text_form_field.dart';
import 'package:tutor_finder/screens/teacher_Information.dart';


class teacher_detail_submission extends StatelessWidget {
  teacher_detail_submission({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final contactNumberController = TextEditingController();
  final subjectController = TextEditingController();
  final timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){
          Get.to(teacherInformation());
        }),
        appBar: AppBar(
          title: Text('Teacher Info Submission'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 38, right: 38),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                customText(text: 'Name'),
                SizedBox(height: 5.h,),
                SizedBox(
                  height: 45.h,
                  child: custom_text_form_field(
                    validate: MultiValidator([
                      RequiredValidator(errorText: 'Name Required'),
                    ]),
                    obscureText: false,
                    text: 'Jhon David',
                    controller: nameController,
                    icon2: Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                customText(text: 'Email'),
                SizedBox(height: 5.h,),
                SizedBox(
                  height: 45.h,
                  child: custom_text_form_field(
                    validate: MultiValidator([
                      EmailValidator(errorText: 'Enter valid Email'),
                    ]),
                    obscureText: false,
                    text: 'David@gmail.com',
                    controller: emailController,
                    icon2: Icon(Icons.email),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                customText(text: 'Address'),
                SizedBox(height: 5.h,),
                SizedBox(
                  height: 45.h,
                  child: custom_text_form_field(
                    validate: MultiValidator([
                      RequiredValidator(errorText: 'Address Required'),
                    ]),
                    obscureText: false,
                    text: 'Your Address',
                    controller: addressController,
                    icon2: Icon(Icons.location_on_outlined),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
               customText(text: 'Contact Number'),
                SizedBox(height: 5.h,),
                SizedBox(
                  height: 45.h,
                  child: custom_text_form_field(
                    validate: MultiValidator([
                      RequiredValidator(errorText: 'Contact Number Required'),
                    ]),
                    obscureText: false,
                    text: '03112342***',
                    controller: contactNumberController,
                    icon2: Icon(Icons.add_call),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                customText(text: 'Subject you teach'),
                SizedBox(height: 5.h,),
                SizedBox(
                  height: 45.h,
                  child: custom_text_form_field(
                    validate: MultiValidator([
                      RequiredValidator(errorText: 'Subject Required'),
                    ]),
                    obscureText: false,
                    text: 'i.e English',
                    controller: subjectController,
                    icon2: Icon(Icons.book),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                customText(text: 'Availability'),
                SizedBox(height: 5.h,),
                SizedBox(
                  height: 45.h,
                  child: custom_text_form_field(
                    validate: MultiValidator([
                      RequiredValidator(errorText: 'Time Required'),
                    ]),
                    obscureText: false,
                    text: 'i.e From 8 to 4',
                    controller: timeController,
                    icon2: Icon(Icons.event_available),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                custom_button(text: "Submit")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
