import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tutor_finder/customText/customText.dart';
import 'package:tutor_finder/custom_button/custom_button.dart';
import 'package:tutor_finder/screens/signIn_screen.dart';

class teacherInformation extends StatelessWidget {
  const teacherInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.logout) ,onPressed: (){
        FirebaseAuth.instance.signOut();
        Get.off(signIn_screen());
      }),
      appBar: AppBar(
        title: Text('Teacher Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 38),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h,),
            customText(text: 'Name'),
            Text('Ahmad'),

            SizedBox(height: 10.h,),
            customText(text: 'Email'),
            Text('asaa@gmail.com'),

            SizedBox(height: 10.h,),
            customText(text: 'Address'),
            Text('District swat '),

            SizedBox(height: 10.h,),
            customText(text: 'Contact Number'),
            Text('234234234'),

            SizedBox(height: 10.h,),
            customText(text: 'Subject'),
            Text('Maths'),

            SizedBox(height: 10.h,),
            customText(text: 'Availability Time'),
            Text('10 to 12'),


          ],
        ),
      ),
    ));
  }
}
