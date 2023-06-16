import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutor_finder/chatScreen/conversationScreen.dart';
import 'package:tutor_finder/constant/constants.dart';
import 'package:tutor_finder/provider/UserSignInViewModel.dart';
import 'package:tutor_finder/provider/manager_signin_viewmodel.dart';
import 'package:tutor_finder/services/DatabaseMethod.dart';

class UserViews extends StatefulWidget {
  String? subtitlee;

  UserViews({Key? key, this.subtitlee}) : super(key: key);

  @override
  State<UserViews> createState() => _UserViewsState();
}

TextEditingController emailControlleruserSearch = TextEditingController();

class _UserViewsState extends State<UserViews> with WidgetsBindingObserver {
  Service service = Service();
  FirebaseAuth user = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //user online
      updateStatus('online');
    } else {
      //user offline
      updateStatus('offline');
    }
  }

  creatChatRoomAndStartConversation(BuildContext context,
      {String? username,
      String? userImage,
      String? providerUserName,
      String? providerImageUrl,
      final String? userId,
      final String? useremail,
      final String? usersubtitle,
      final String? userprofileRing}) async {
    print("helllllllllllllllo ${providerUserName}");
    if (username != providerUserName) {
      String chatRoomId = await getChatRoomId(username!, providerUserName!);

      List<String> users = [username, providerUserName];
      Map<String, dynamic> chatRoomMap = {
        "user": users,
        username: userImage,
        providerUserName: providerImageUrl,
        "chatRoomId": chatRoomId
      };

      DatabaseMethod().createChatRoom(chatRoomId, chatRoomMap);
      print("done");
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ConversationScreen(
      //               chatRoomId: chatRoomId,
      //               userName: username,
      //               imageUrl: userImage,
      //               // userId: userId,
      //               useremail: useremail,
      //               usersubtitle: usersubtitle,
      //               userprofilering: userprofileRing,
      //             )));

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(
                    chatRoomId: chatRoomId,
                    userName: username,
                    imageUrl: userImage,
                    userId: userId,
                    useremail: useremail,
                    usersubtitle: usersubtitle,
                    userprofilering: userprofileRing,
                  )));
    } else {
      print("you can not send messege to yourself");
    }
  }

  updateStatus(status) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.currentUser!.uid)
        .update({'status': status});
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  String? myName;
  String? myImage;

  @override
  void initState() {
    super.initState();
    getMydata();
  }

  void getMydata() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser!;
    final uid = user.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then(
        (value) =>
            {myName = value.get('userName'), myImage = value.get('imageUrl')});

    print('aaaaaaaaaaaaaaaahssssssssssssssssssssssssss${myName}');
  }

  String? grenn = 'help/listen';
  String name = '';

  @override
  Widget build(BuildContext context) {
    // final allUsersProvider =
    //     Provider.of<ManagerSignInViewModel>(context, listen: false);
    FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser!;
    final uid = user.uid;
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
          backgroundColor: Colors.green.withOpacity(0.5),

          title: Text(
            'Teachers',
            style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.green.withOpacity(0.6),
                  ])),
          child: Column(
            children: [
              Constants.vSpace(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      //  (name != "" && name != null)
                      // ?
                      FirebaseFirestore.instance
                          .collection("users")
                          // .where("blocked", isNotEqualTo: [uid.toString()])
                          // .where("subtitleRole", isEqualTo: selectedCategoryname)
                          .where("role", isNotEqualTo: 'student')
                          .snapshots(),
                  // : allUsersProvider.getAllUsers().asStream(),
                  builder: (context, snapshot) {
                    return (snapshot.connectionState == ConnectionState.waiting &&
                            snapshot.data == null)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            //     maxCrossAxisExtent: 400,
                            // childAspectRatio: 3 / 2,
                            // crossAxisSpacing: 20,
                            // mainAxisSpacing: 20
                            //   ),
                            // here we use our demo procuts list
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot data = snapshot.data!.docs[index];
                              // print("uiddddd ${uid}");

                              return GestureDetector(
                                onTap: () {
                                  creatChatRoomAndStartConversation(context,
                                      username: data['userName'],
                                      userImage: data['imageUrl'],
                                      userId: data['UID'],
                                      useremail: data['email'],
                                      providerUserName: myName,
                                      //  allUsersProvider
                                      //     .userModel.userName
                                      //     .toString(),
                                      providerImageUrl: myImage
                                      // allUsersProvider
                                      //     .userModel.imageUrl
                                      //     .toString()
                                      );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 2.0, right: 8.0),
                                  child: Container(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 30, // Image radius
                                        backgroundImage:
                                            NetworkImage(data['imageUrl']),
                                      ),

                                      //     Container(
                                      //   width: 70,
                                      //   height: 90,
                                      //   decoration: BoxDecoration(
                                      //     color: Constants.imageBorderColor,
                                      //     image: DecorationImage(
                                      //       fit: BoxFit.cover,
                                      //       image:
                                      //           NetworkImage(data['imageUrl']),
                                      //     ),
                                      //     borderRadius: const BorderRadius.all(
                                      //       Radius.circular(
                                      //         3,
                                      //       ),
                                      //     ),
                                      //     border: Border.all(
                                      //       color: Colors.green,
                                      //       // color: Colors.black,
                                      //       width: 6,
                                      //     ),
                                      //   ),
                                      // ),
                                      title: Text(
                                        data['userName'].toString().toUpperCase(),
                                        style: Constants.bodyTextBold,
                                      ),
                                      subtitle: Text(
                                          // data['status']
                                          //     .toString()
                                          //     .toUpperCase(),
                                          'testt',
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.black)),
                                    ),
                                  ),
                                ),
                              );
                            });
                  },
                ),
              ),
            ],
          ),
        ),
      ));
  }
}
