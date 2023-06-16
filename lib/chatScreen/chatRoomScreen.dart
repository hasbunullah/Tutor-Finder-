import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/provider/UserSignInViewModel.dart';
import 'package:tutor_finder/services/DatabaseMethod.dart';
import 'conversationScreen.dart';

class ChatRoom extends StatefulWidget {
// const ChatRoom({Key? key}) : super(key: key);
//   static const routeName = '/chatRoom';
  late DocumentSnapshot data;
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  DatabaseMethod databaseMethod = DatabaseMethod();
  Stream<QuerySnapshot>? chatRoomStream;
  // Widget chatRoomList() {
  //     return }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    UserSignInViewModel userProvider =
        Provider.of<UserSignInViewModel>(context, listen: false);

    databaseMethod.getChatRooms(userProvider.userModel.userName!).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserSignInViewModel userProvider =
        Provider.of<UserSignInViewModel>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Constants.vSpace(),
              // Logo(),
              Container(
                  height: 95,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: chatRoomStream,
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return ChatRoomList(
                                    userName: snapshot
                                        .data!.docs[index]["chatRoomId"]
                                        .toString()
                                        .replaceAll("_", "")
                                        .replaceAll(
                                            userProvider.userModel.userName
                                                .toString(),
                                            ""),
                                    chatRoomId: snapshot.data!.docs[index]
                                        ["chatRoomId"],
                                    imageurl: snapshot
                                        .data!
                                        .docs[index][snapshot
                                            .data!.docs[index]["chatRoomId"]
                                            .toString()
                                            .replaceAll("_", "")
                                            .replaceAll(
                                                userProvider.userModel.userName
                                                    .toString(),
                                                "")]
                                        .toString(),
                                  );
                                })
                            : Container();
                      }))
            ],
          ),
        ),
      ),
    );
  }
}

class ChatRoomList extends StatelessWidget {
  final String userName;
  final String imageurl;
  final String chatRoomId;
  final String? profileRing;
  final String? status;
  const ChatRoomList(
      {Key? key,
      required this.userName,
      required this.chatRoomId,
      required this.imageurl,
      this.profileRing,
      this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(
                      chatRoomId: chatRoomId,
                      userName: userName,
                      imageUrl: imageurl,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(50),
          //   color: Palette.secondary,
          // ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 65,
                width: 65,
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          3,
                        ),
                      ),
                      border: Border.all(
                        // color: Constants.imageBorderColor,
                        color: Colors.black,
                        width: 6,
                      ),
                      image: DecorationImage(
                          image: NetworkImage(imageurl), fit: BoxFit.cover)),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    userName,
                    // style: Constants.bodyTextBold,
                  ),
                  // Text(
                  //   'test',
                  //   style: Constants.bodyTextBold,
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
