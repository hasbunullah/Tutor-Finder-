import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor_finder/screens/teacher/servicesbooked.dart';

import '../../constant/Palette.dart';
import '../../constant/color_constant.dart';
import '../../constant/constant_font.dart';
import '../../constant/string_constant.dart';

class UserTaskDescription extends StatefulWidget {
  UserTaskDescription({
    Key? key,
    required this.data,
  }) : super(key: key);

  DocumentSnapshot data;

  @override
  State<UserTaskDescription> createState() => _UserTaskDescriptionState();
}

class _UserTaskDescriptionState extends State<UserTaskDescription> {
  var _bottomNavIndex = 0;
  late AnimationController _animationController;

  late Animation<double> animation;

  late CurvedAnimation curve;

  // DatabaseMethod databaseMethod = new DatabaseMethod();

  ScrollController _scrollController = ScrollController();

  Stream<QuerySnapshot>? chatMessageStream;

  @override
  void initState() {
    // getConversationMessage(widget.data!.id).then((value){
    //   setState((){
    //     chatMessageStream = value;
    //   });    });
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void updateDtaAccept() async {
    FirebaseFirestore.instance
        .collection('servicesrequest')
        .doc(widget.data.id)
        .update({"status": "accept"}).then((result) {
      print("new USer true");
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ServicesBookedScreen()));
    }).catchError((onError) {
      print("onError");
    });
  }

  void updateDtacancel() async {
    FirebaseFirestore.instance
        .collection('servicesrequest')
        .doc(widget.data.id)
        .update({"status": "cancel"}).then((result) {
      print("new USer true");
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ServicesBookedScreen()));
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
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: blackColor,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          StringConstant.requestService,
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
                  Colors.green.withOpacity(0.6),
                ])),
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Student Name : ${widget.data['studentName']}',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Subject : ${widget.data['subject']}',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Tution Fee : ${widget.data['servicePrice']}',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Tution Time : ${widget.data['servicesTime']}',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.h,
                ),

                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Container(
                            width: 130,
                            margin: const EdgeInsets.only(top: 5.0),
                            alignment: FractionalOffset.center,
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width * .90,
                              height: 45,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.green.withOpacity(0.5),
                              onPressed: () {
                                updateDtaAccept();
                              },
                              child: Text(
                                StringConstant.accept,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: ConstantFont.montserratMedium,
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Container(
                            width: 130,
                            margin: const EdgeInsets.only(top: 5.0),
                            alignment: FractionalOffset.center,
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width * .90,
                              height: 45,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.green.withOpacity(0.5),
                              onPressed: () {
                                print('serviceeeeeessssss');
                                updateDtacancel();
                              },
                              child: Text(
                                StringConstant.cancal,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: ConstantFont.montserratMedium,
                                ),
                              ),
                            )),
                      ),
                    ],
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
