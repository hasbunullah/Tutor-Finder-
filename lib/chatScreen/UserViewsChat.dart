import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/chatScreen/conversationScreen.dart';
import 'package:tutor_finder/constant/constants.dart';
import 'package:tutor_finder/provider/UserSignInViewModel.dart';
import 'package:tutor_finder/services/DatabaseMethod.dart';

class UserViewsChat extends StatefulWidget {
  const UserViewsChat({Key? key}) : super(key: key);

  @override
  State<UserViewsChat> createState() => _UserViewsState();
}

class _UserViewsState extends State<UserViewsChat> with WidgetsBindingObserver {
  Service service = Service();
  FirebaseAuth user = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (state == AppLifecycleState.resumed) {
    //   //user online
    //   updateStatus('online');
    // } else {
    //   //user offline
    //   updateStatus('offline');
    // }
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

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(
                    chatRoomId: chatRoomId,
                    userName: username,
                    imageUrl: userImage,
                    // userId: widget.userId,
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
    // db.collection("users");
    // db.doc(user.currentUser!.uid).update({"status": status})
    //     // .then((result) {
    //     //   print("the status update$status");
    //     // }).catchError((onError) {
    //     //   print("onError");
    //     // })
    //     ;
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

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsersChat(
      String fulname) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("user", arrayContains: fulname)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    // final allUsersProvider =
    //     Provider.of<UserSignInViewModel>(context, listen: false);

    return myName == ''
        ? CircularProgressIndicator()
        : SafeArea(
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
                title: Center(
                    child: Text(
                  'Inbox',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                )),
                backgroundColor: Colors.green.withOpacity(0.5),
              ),
              backgroundColor: Constants.listCardBackground,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Constants.vSpace(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: getAllUsersChat(myName.toString()).asStream(),
                        builder: (context, snapshot) {
                          return (snapshot.connectionState ==
                                      ConnectionState.waiting &&
                                  snapshot.data == null)
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot data =
                                        snapshot.data!.docs[index];
                                    // if(data['blocked'] == ){}
                                    return GestureDetector(
                                      onTap: () {
                                        creatChatRoomAndStartConversation(context,
                                            username: data['user'] == myName
                                                ? data['user'][0]
                                                    .toString()
                                                    .toLowerCase()
                                                : data['user'][1]
                                                    .toString()
                                                    .toLowerCase(),
                                            userImage: data[
                                                '${data['user'] == myName ? {
                                                    '${data['user'][0].toString()}'
                                                  } : '${data['user'][1].toString()}'}'],
                                            // userId: data['UserUID'],
                                            useremail: 'testemail',
                                            providerUserName: myName.toString(),
                                            providerImageUrl: myImage.toString());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 2.0, left: 0, right: 10.0),
                                        child: Container(
                                          child: ListTile(
                                            leading:
                                                // CircleAvatar(
                                                //   radius: 48, // Image radius
                                                //   backgroundImage:
                                                //       NetworkImage(data['imageUrl']),
                                                // ),

                                                CircleAvatar(
                                              radius: 30, // Image radius
                                              backgroundImage: NetworkImage(data[
                                                  '${data['user'] == myName ? {
                                                      '${data['user'][0].toString()}'
                                                    } : '${data['user'][1].toString()}'}']),
                                            ),
                                            title: Padding(
                                              padding: const EdgeInsets.only(
                                                  left:0),
                                              child: Text(
                                                data['user'] == myName
                                                    ? data['user'][0]
                                                        .toString()
                                                        .toUpperCase()
                                                    : data['user'][1]
                                                        .toString()
                                                        .toUpperCase(),
                                                // 'username',
                                                style: Constants.bodyTextBold,
                                              ),
                                            ),
                                            subtitle: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0),
                                              child: Text('test',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black)),
                                            ),
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
            ),
          );
  }
}
