import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/chatScreen/Widgets/theme_helper.dart';
import 'package:tutor_finder/chatScreen/show_conversation_image.dart';
import 'package:tutor_finder/constant/Palette.dart';
import 'package:tutor_finder/constant/constants.dart';
import 'package:tutor_finder/provider/UserSignInViewModel.dart';
import 'package:tutor_finder/provider/widgets_viewmodel.dart';
import 'package:tutor_finder/services/DatabaseMethod.dart';

class ConversationScreen extends StatefulWidget {
  final String? chatRoomId;
  final String? userName;
  final String? imageUrl;
  final String? userId;
  final String? useremail;
  final String? usersubtitle;
  final String? userprofilering;

  const ConversationScreen(
      {Key? key,
      this.chatRoomId,
      this.userName,
      this.imageUrl,
      this.userId,
      this.useremail,
      this.usersubtitle,
      this.userprofilering})
      : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethod databaseMethod = new DatabaseMethod();
  TextEditingController messagecontroller = new TextEditingController();

  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String? myName;
  String? myImage;

  @override
  void initState() {
    databaseMethod.getConversationMessage(widget.chatRoomId!).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    _scrollController = ScrollController();
    getMydata();

    super.initState();
  }

  void getMydata() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser!;
    final uid = user.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then(
        (value) =>
            {myName = value.get('userName'), myImage = value.get('imageUrl')});

  }

  Stream<QuerySnapshot>? chatMessageStream;
  String? userName;

//  print(
//                                       "userName  ${provider.userModel.userName}");
  Widget chatMessageList() {
    // WidgetsViewModel userProvider =
    //     Provider.of<WidgetsViewModel>(context, listen: false);
    return StreamBuilder<QuerySnapshot>(
        stream: chatMessageStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                      message: snapshot.data!.docs[index]["message"],
                      isSendByMe:
                          snapshot.data!.docs[index]["sendby"] == myName,
                      // userProvider.userModel.userName.toString(),
                      isImage: snapshot.data!.docs[index]["type"] == 'img',
                    );
                  })
              : Container();
        });
  }

  sendMessage() {
    // UserSignInViewModel userProvider =
    //     Provider.of<UserSignInViewModel>(context, listen: false);
    if (messagecontroller.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messagecontroller.text,
        "type": "text",
        "sendby": myName,
        //  userProvider.userModel.userName.toString(),
        "time": DateTime.now().microsecondsSinceEpoch
      };
      databaseMethod.addConversationMessage(widget.chatRoomId!, messageMap);
      messagecontroller.text = "";
    }
  }

  Reference? task2;
  String? imageUrlDownload;
  ImagePicker _picker = ImagePicker();
  XFile? image;

  File? imageFile;

  void _remove() {
    setState(() {
      imageFile = null;
    });
    Navigator.pop(context);
  }

  sendImage() {
    UserSignInViewModel userProvider =
        Provider.of<UserSignInViewModel>(context, listen: false);
    if (imageUrlDownload!.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": imageUrlDownload,
        "type": "img",
        "sendby": userProvider.userModel.userName.toString(),
        "time": DateTime.now().microsecondsSinceEpoch
      };
      databaseMethod.addConversationMessage(widget.chatRoomId!, messageMap);
      imageUrlDownload = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    // here we set the timer to call the event
    // Timer(
    //     Duration(milliseconds: 200),
    //     () => _scrollController
    //         .jumpTo(_scrollController.position.maxScrollExtent));
    return Scaffold(
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => UserProfileScreen(
                //               userName: widget.userName,
                //               imageUrl: widget.imageUrl,
                //               // userId: widget.userId,
                //               useremail: widget.useremail,
                //               usersubtitle: widget.usersubtitle,
                //             )));
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                        image: NetworkImage(widget.imageUrl!),
                        fit: BoxFit.cover)),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(widget.userName!,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700))
          ],
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: chatMessageList(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20) ),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.green.withOpacity(0.6),
                          Colors.white,
                        ])),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: messagecontroller,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: "Message...",
                            hintStyle:
                                TextStyle(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut);
                        sendMessage();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        padding: EdgeInsets.only(
                          left: 5,
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFF5454FF),
                            // gradient: LinearGradient(
                            //     begin: Alignment.topLeft,
                            //     end: Alignment.bottomRight,
                            //     colors: [
                            //       //   Palette.fullBlue,
                            //       //   Palette.deepBlue,
                            //       //   Palette.fullBlue,
                            //     ]),
                            borderRadius: BorderRadius.circular(40)),
                        child: Icon(Icons.send, color: Colors.white,size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectCameraImage() async {
    image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = File(image!.path);
    });
    await uploadImage();
    await sendImage();
    Navigator.pop(context, false);
  }

  void selectGalleryImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(image!.path);
    });
    await uploadImage();
    await sendImage();

    Navigator.pop(context, false);
  }

  Future uploadImage() async {
    final destination = 'chat/images/$imageFile';

    task2 = FirebaseStorage.instance.ref(destination);

    if (imageFile == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please Upload your Picture")));
    }

    await task2!.putFile(File(imageFile!.path));

    imageUrlDownload = await task2!.getDownloadURL();

    print('Download-link: $imageUrlDownload');
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('userName', userName));
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  final bool isImage;

  const MessageTile(
      {Key? key,
      required this.message,
      required this.isSendByMe,
      required this.isImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isImage
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowConversationImage(
                            message: message,
                          )));
            },
            child: Container(
              padding: EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: isSendByMe ? 0 : 24,
                  right: isSendByMe ? 24 : 0),
              alignment:
                  isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                height: 250,
                width: 200,
                decoration: BoxDecoration(
                    color: Color(0xa4dbfc).withOpacity(.20),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xa4dbfc)),
                    image: DecorationImage(
                        image: NetworkImage(message), fit: BoxFit.contain)),
                // child: Image.network(message, fit: BoxFit.contain,)
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: isSendByMe ? 0 : 24,
                right: isSendByMe ? 24 : 0),
            alignment:
                isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: isSendByMe
                  ? EdgeInsets.only(left: 30)
                  : EdgeInsets.only(right: 30),
              padding:
                  EdgeInsets.only(top: 12, bottom: 17, left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: isSendByMe
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(23),
                          topRight: Radius.circular(23),
                          bottomLeft: Radius.circular(23))
                      : const BorderRadius.only(
                          topLeft: Radius.circular(23),
                          topRight: Radius.circular(23),
                          bottomRight: Radius.circular(23)),
                color: isSendByMe ? Color(0xFF5454FF) :Color(0xFF3D3D3D),
                // gradient: LinearGradient(
                  //   colors: isSendByMe
                  //       ? [
                  //           Constants.imageBorderColor,
                  //           Constants.imageBorderColor
                  //         ]
                  //       : [
                  //           Constants.primaryColor,
                  //           Constants.primaryColor
                  //           // Color.fromARGB(255, 99, 182, 102),
                  //           // Color.fromARGB(255, 99, 182, 102)
                  //         ],
                  // ),
              ),
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
  }
}
