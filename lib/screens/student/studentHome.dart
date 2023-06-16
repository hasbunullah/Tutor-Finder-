import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_finder/chatScreen/UserViews.dart';
import 'package:tutor_finder/customText/customText2.dart';
import 'package:tutor_finder/screens/student/studentCategoryScreen.dart';

import '../signIn_screen.dart';

class StudentHome extends StatefulWidget {
  StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth user = FirebaseAuth.instance;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.currentUser!.uid)
        .update({"UID": user.currentUser!.uid}).then((result) {
      print("new USer true");
    }).catchError((onError) {
      print("onError");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.green.withOpacity(0.3),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          backgroundColor: Colors.green.withOpacity(0.5),
          automaticallyImplyLeading: false,
          title: Text(
            'Subjects',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5, top: 10, bottom: 10),
              child: GestureDetector(
                onTap: (() {
                  Get.to(UserViews());
                }),
                child: Center(
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.message,
                      )
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5, top: 10, bottom: 10),
              child: GestureDetector(
                onTap: (() {
                  signOut();
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) => signIn_screen()));
                 }),
                child: Center(
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.logout,
                      ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/logo.png"), fit: BoxFit.cover),
          ),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Colors.white,
                  Colors.green.withOpacity(0.6),
                ])),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(CategoryScreen(
                        subjectName: 'English',
                      ));
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
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.green.withOpacity(0.5),
                                  Colors.white,
                                ]),
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
                  InkWell(
                    onTap: () {
                      Get.to(CategoryScreen(
                        subjectName: 'Mathematics',
                      ));
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
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.green.withOpacity(0.5),
                                  Colors.white
                                ]),
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
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(CategoryScreen(
                        subjectName: 'Physics',
                      ));
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
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.green.withOpacity(0.5),
                                  Colors.white,
                                ]),
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
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(CategoryScreen(
                        subjectName: 'Chemistry',
                      ));
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
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.green.withOpacity(0.5),
                                  Colors.white,
                                ]),
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
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(CategoryScreen(
                        subjectName: 'Computer',
                      ));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color(0xff82CD47),
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.green.withOpacity(0.5),
                                  Colors.white,
                                ]),
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
                            title: customText2(text: 'Computer'),
                            leading: Image.asset('assets/images/book.png')),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(CategoryScreen(
                        subjectName: 'Urdu',
                      ));
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
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.green.withOpacity(0.5),
                                  Colors.white,
                                ]),
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
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
