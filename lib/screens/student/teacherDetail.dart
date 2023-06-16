import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor_finder/constant/Palette.dart';
import 'package:tutor_finder/constant/color_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:tutor_finder/constant/constant_font.dart';
import 'package:tutor_finder/constant/string_constant.dart';
import 'package:tutor_finder/models/createRequest.dart';

class TeacherDetails extends StatefulWidget {
  DocumentSnapshot data;

  TeacherDetails({
    required this.data,
  });

  @override
  State<TeacherDetails> createState() => _TeacherDetailsState();
}

class _TeacherDetailsState extends State<TeacherDetails> {
  @override
  void initState() {
    super.initState();
    getMydata();
  }

  String? myName;
  String? myImage;

  void getMydata() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser!;
    final uid = user.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then(
        (value) =>
            {myName = value.get('userName'), myImage = value.get('imageUrl')});

    print('aaaaaaaaaaaaaaaahssssssssssssssssssssssssss${myName}');
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
          'Request to Teacher',
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
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.white,
                  Colors.green.withOpacity(0.6),
                ])),
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ///////// teacher imageeeeeeeeeeeeeeeeeeeeeeee
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.amber,
                                image: DecorationImage(
                                    image: NetworkImage(widget.data["image"]),
                                    fit: BoxFit.cover)),
                            height: 90,
                            width: 90,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Teacher Name : ${widget.data['teacherName']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Subject : ${widget.data['subject']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Timming : ${widget.data['servicesTime']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Tution Fee : ${widget.data['servicePrice']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Phone Number : ${widget.data['phoneNum']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'City : ${widget.data['city']}\n',
                                // widget.data['mask'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
               
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        FirebaseAuth user = FirebaseAuth.instance;

                        FirebaseFirestore.instance
                            .collection('servicesrequest')
                            .add(CreateRequestModel(
                                    teacherName: '${widget.data['teacherName']}',
                                    serviceTime: '${widget.data['servicesTime']}',
                                    servicePrice:
                                        '${widget.data['servicePrice']}',
                                    phone: '${widget.data['phoneNum']}',
                                    file: '${widget.data['file']}',
                                    image: '${widget.data['image']}',
                                    userImage: myImage,
                                    uId: '${widget.data['UID']}',
                                    subject: '${widget.data['subject']}',
                                    city: '${widget.data['city']}',
                                    studentUid: '${user.currentUser!.uid}',
                                    studentName: myName)
                                .toMap())
                            .then((value) => {Navigator.pop(context)})
                            .catchError((e) {
                          print(e.toString());
                        });

                        // CustomWidgets().successAwesomeDialog(
                        //     context, "Task created Successfully");
                      },
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green.withOpacity(0.5),
                        ),
                        child: Center(
                            child: Text(
                          "Request Now",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
