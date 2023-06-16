import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_finder/screens/UserTaskDescription.dart';
import 'package:tutor_finder/screens/signIn_screen.dart';

import '../../../constant/color_constant.dart';
import '../../../constant/constant_font.dart';
import '../../../constant/string_constant.dart';

class ServicesBookedScreen extends StatefulWidget {
  ServicesBookedScreen({Key? key}) : super(key: key);

  @override
  State<ServicesBookedScreen> createState() => _ServicesBookedScreenState();
}

class _ServicesBookedScreenState extends State<ServicesBookedScreen> {
  final User currentUser = FirebaseAuth.instance.currentUser!;

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

  Future<String?> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.code}: ${ex.message}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              title: Text(
                StringConstant.bookService,
                style: TextStyle(
                    color: blackColor,
                    fontFamily: ConstantFont.montserratBold,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    signOut();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => signIn_screen()));
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.login_outlined,
                              color: Colors.black,
                              size: 18,
                            )),
                      )),
                )
              ],
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
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder<QuerySnapshot>(
                // <2> Pass `Stream<QuerySnapshot>` to stream
                stream: FirebaseFirestore.instance
                    .collection('servicesrequest')
                    .where('UID', isEqualTo: currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;

                    return ListView(
                        children: documents
                            .map((doc) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserTaskDescription(
                                                    data: doc,
                                                  )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Colors.green.withOpacity(0.6),
                                                Colors.white,
                                              ]),
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                      child: Container(
                                        child: Card(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Colors.green
                                                        .withOpacity(0.6),
                                                    Colors.white,
                                                  ]),
                                            ),
                                            child: Row(children: [
                                              Container(
                                                height: 90,
                                                width: 130,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          'https://4.imimg.com/data4/YM/AY/GLADMIN-17254102/1-500x500.jpg'),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, left: 10),
                                                child: Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    height: 90,
                                                    child: Column(children: [
                                                      Center(
                                                        child: Text(
                                                          'New Request \n ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Date \n ${doc.get('servicesTime')}  ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, left: 5),
                                                child: Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    height: 90,
                                                    child: Column(children: [
                                                      Text(
                                                        '\n\nService status \n  ${doc.get('status')}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ),
                                        ),
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
            )));
  }
}
