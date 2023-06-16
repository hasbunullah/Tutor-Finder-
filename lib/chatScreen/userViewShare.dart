import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutor_finder/constant/constants.dart';
import 'package:tutor_finder/provider/UserSignInViewModel.dart';
import 'package:tutor_finder/services/DatabaseMethod.dart';

class UserViewShare extends StatefulWidget {
  const UserViewShare({Key? key}) : super(key: key);

  @override
  State<UserViewShare> createState() => _UserViewsState();
}

class _UserViewsState extends State<UserViewShare> with WidgetsBindingObserver {
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

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => UserProfileScreen(
      //               chatRoomId: chatRoomId,
      //               userName: username,
      //               imageUrl: userImage,
      //               // userId: widget.userId,
      //               useremail: useremail,
      //               usersubtitle: usersubtitle,
      //               userprofilering: userprofileRing,
      //             )));
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

  @override
  void initState() {
    super.initState();
    // updateStatus('online');
    // WidgetsBinding.instance.addObserver(this);
  }

  String? grenn = 'help/listen';

  @override
  Widget build(BuildContext context) {
    final allUsersProvider =
        Provider.of<UserSignInViewModel>(context, listen: false);
    TextEditingController emailController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.landingScreenColor,
        body: Column(
          children: [
            Constants.vSpace(),
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      color: Colors.white,
                      height: 58,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                            hintText: "search.."),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.white,
                      child: InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => FilterScreen()));
                          },
                          child: const Icon(Icons.filter)),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  allUsersProvider.userModel.email.toString(),
                  style: Constants.mainHeading,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: StreamBuilder<QuerySnapshot>(
                stream: allUsersProvider.getAllUsershare().asStream(),
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
                            // if(data['blocked'] == ){}
                            return GestureDetector(
                              onTap: () {
                                creatChatRoomAndStartConversation(context,
                                    username: data['fullName'],
                                    userImage: data['imageUrl'],
                                    // userId: data['UserUID'],
                                    useremail: data['email'],
                                    usersubtitle: data['subtitleRole'],
                                    userprofileRing: data['profileRing'],
                                    providerUserName: allUsersProvider
                                        .userModel.userName
                                        .toString(),
                                    providerImageUrl: allUsersProvider
                                        .userModel.imageUrl
                                        .toString());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 2.0, left: 10.0, right: 10.0),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: ListTile(
                                      leading:
                                          // CircleAvatar(
                                          //   radius: 48, // Image radius
                                          //   backgroundImage:
                                          //       NetworkImage(data['imageUrl']),
                                          // ),
                                          data['profileRing'] == grenn
                                              ? Container(
                                                  width: 70,
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                    color: Constants
                                                        .imageBorderColor,
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          data['imageUrl']),
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(
                                                        3,
                                                      ),
                                                    ),
                                                    border: Border.all(
                                                      color: Colors.green,
                                                      // color: Colors.black,
                                                      width: 6,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: 70,
                                                  height: 90,
                                                  decoration: BoxDecoration(
                                                    color: Constants
                                                        .imageBorderColor,
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          data['imageUrl']),
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(
                                                        3,
                                                      ),
                                                    ),
                                                    border: Border.all(
                                                      color: Constants
                                                          .imageBorderColor,
                                                      // color: Colors.black,
                                                      width: 6,
                                                    ),
                                                  ),
                                                ),
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          data['userName']
                                              .toString()
                                              .toUpperCase(),
                                          style: Constants.bodyTextBold,
                                        ),
                                      ),
                                      subtitle: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                            data['status']
                                                .toString()
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black)),
                                      ),
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
    );
  }
}
