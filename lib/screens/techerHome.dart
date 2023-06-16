import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_finder/customText/customText2.dart';
import 'package:tutor_finder/screens/signIn_screen.dart';
import 'package:tutor_finder/screens/teacher_detail_submission.dart';
import 'package:tutor_finder/screens/teachers.dart';

class TeacherHome extends StatefulWidget {
  TeacherHome({Key? key}) : super(key: key);

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(0.5),
        automaticallyImplyLeading: false,
        title: Text(
          'Subjects',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(signIn_screen());
          // Get.to(teacher_detail_submission());
        },
        backgroundColor: Color(0xff82CD47),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.to(teachers());
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(0xff82CD47),
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.green.withOpacity(0.5),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(1, 2),
                            blurRadius: 5,
                            blurStyle: BlurStyle.outer
                            // blurStyle: BlurStyle.inner
                            ),
                      ]),
                  height: 70,
                  child: ListTile(
                      title: customText2(text: 'English'),
                      leading: Image.asset('assets/images/book.png')),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(0xff82CD47),
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green.withOpacity(0.5),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(1, 2),
                          blurRadius: 5,
                          blurStyle: BlurStyle.outer
                          // blurStyle: BlurStyle.inner
                          ),
                    ]),
                height: 70,
                child: ListTile(
                    title: customText2(text: 'Mathematics'),
                    leading: Image.asset('assets/images/book.png')),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(0xff82CD47),
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green.withOpacity(0.5),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(1, 2),
                          blurRadius: 5,
                          blurStyle: BlurStyle.outer
                          // blurStyle: BlurStyle.inner
                          ),
                    ]),
                height: 70,
                child: ListTile(
                    title: customText2(text: 'Physics'),
                    leading: Image.asset('assets/images/book.png')),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(0xff82CD47),
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green.withOpacity(0.5),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(1, 2),
                          blurRadius: 5,
                          blurStyle: BlurStyle.outer
                          // blurStyle: BlurStyle.inner
                          ),
                    ]),
                height: 70,
                child: ListTile(
                    title: customText2(text: 'Chemistry'),
                    leading: Image.asset('assets/images/book.png')),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(0xff82CD47),
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green.withOpacity(0.5),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(1, 2),
                          blurRadius: 5,
                          blurStyle: BlurStyle.outer
                          // blurStyle: BlurStyle.inner
                          ),
                    ]),
                height: 70,
                child: ListTile(
                    title: customText2(text: 'Urdu'),
                    leading: Image.asset('assets/images/book.png')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
