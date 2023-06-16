import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor_finder/constant/color_constant.dart';
import 'package:tutor_finder/constant/constant_font.dart';
import 'package:tutor_finder/constant/string_constant.dart';
import 'package:tutor_finder/screens/student/teacherDetail.dart';

class CategoryScreen extends StatefulWidget {
  String? subjectName;
  CategoryScreen({this.subjectName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

FirebaseAuth user = FirebaseAuth.instance;

Future<String?> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();

    return null;
  } on FirebaseAuthException catch (ex) {
    return "${ex.code}: ${ex.message}";
  }
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.green,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: blackColor,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Teacher List',
            // '${widget.subjectName}',
            style: TextStyle(
                color: blackColor,
                fontFamily: ConstantFont.montserratBold,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.green.withOpacity(0.5),
          elevation: 0.0,
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.green.withOpacity(0.6),
                  ])),
          height: double.infinity,
          child: StreamBuilder<QuerySnapshot>(
            // <2> Pass `Stream<QuerySnapshot>` to stream
            stream: FirebaseFirestore.instance
                .collection("services")
                .where('subject', isEqualTo: widget.subjectName)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                print('${documents.length}');
                return ListView(
                    children: documents
                        .map((doc) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TeacherDetails(
                                        data: doc,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.white,
                                              Colors.green.withOpacity(0.6),
                                            ]),

                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: Offset(2, 4),
                                        spreadRadius: 0.6,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Card(
                                    child: Row(children: [
                                      Expanded(
                                          child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                image:
                                                    NetworkImage(doc["image"]),
                                                fit: BoxFit.cover)),
                                        height: 90,
                                      )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      Colors.white,
                                                      Colors.green.withOpacity(0.6),
                                                    ]),

                                            borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                                          ),
                                          height: 90,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 5.h),
                                                Text(
                                                  'Name   : ${doc["teacherName"]}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.sp),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text(
                                                  'subject   : ${doc["subject"]}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text(
                                                  'Services Time : ${doc["servicesTime"]}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ]),
                                        ),
                                      )
                                    ]),
                                  ),
                                ),
                              ),
                            ))
                        .toList());
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));

    //     SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       Container(
    //         child: StreamBuilder(
    //           stream:
    //           builder: (context, snapshot) {
    //             if (!snapshot.hasData) {
    //               return CircularProgressIndicator();
    //             } else {
    //               return Stack(
    //                 children: [
    //                   GridView.builder(
    //                     itemCount: snapshot.data!.docs.length,
    //                     physics: ScrollPhysics(),
    //                     scrollDirection: Axis.vertical,
    //                     shrinkWrap: true,
    //                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //                         crossAxisCount: 2,
    //                         crossAxisSpacing: 10,
    //                         mainAxisSpacing: 5),
    //                     itemBuilder: (context, index) {
    //                       return GestureDetector(
    //                         onTap: () {
    //                           // Navigator.of(context).push(MaterialPageRoute(
    //                           //     builder: (context) => BookingScreenCustomer(
    //                           //           uid:
    //                           //               snapshot.data!.docs[index].get('UID'),
    //                           //         )));
    //                         },
    //                         child: Padding(
    //                           padding: const EdgeInsets.only(bottom: 8.0),
    //                           child: Container(
    //                               height: 250.h,
    //                               width: 250.w,
    //                               decoration: BoxDecoration(
    //                                   borderRadius: BorderRadius.circular(20),
    //                                   image: DecorationImage(
    //                                       image: NetworkImage(snapshot
    //                                           .data!.docs[index]
    //                                           .get("image")),
    //                                       fit: BoxFit.cover)),
    //                               child: Column(
    //                                   mainAxisAlignment: MainAxisAlignment.end,
    //                                   children: [
    //                                     Text(
    //                                       "Name : ${snapshot.data!.docs[index].get("servicesName")}",
    //                                       style: TextStyle(
    //                                           color: Colors.white,
    //                                           fontSize: 15),
    //                                     ),
    //                                     Text(
    //                                       "Price : ${snapshot.data!.docs[index].get("servicePrice")}",
    //                                       style: TextStyle(
    //                                           color: Colors.white,
    //                                           fontSize: 15),
    //                                     )
    //                                   ])),
    //                         ),
    //                       );
    //                     },
    //                   ),
    //                 ],
    //               );
    //             }
    //           },
    //         ),
    //       ),
    //       Container(
    //           margin: const EdgeInsets.only(top: 5.0),
    //           alignment: FractionalOffset.center,
    //           child: MaterialButton(
    //             minWidth: MediaQuery.of(context).size.width * .90,
    //             height: 45,
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(8),
    //             ),
    //             color: pinkColor,
    //             onPressed: () {
    //               // Navigator.of(context).push(MaterialPageRoute(
    //               //     builder: (context) => FindSaloonScreen()));
    //             },
    //             child: Text(
    //               StringConstant.findnear,
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                 color: whiteColor,
    //                 fontSize: 18,
    //                 fontWeight: FontWeight.w600,
    //                 fontFamily: ConstantFont.montserratMedium,
    //               ),
    //             ),
    //           )),
    //     ],
    //   ),
    // ));
  }
}
