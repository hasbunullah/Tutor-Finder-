import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/chatScreen/Widgets/theme_helper.dart';
import 'package:tutor_finder/services/DatabaseMethod.dart';

import '../conversationScreen.dart';

class ChatRoomWidgets{

  creatChatRoomAndStartConversation(
    BuildContext context, {String? username, String? userImage, String? providerUserName,
     String? providerImageUrl}) async {
    print("helllllllllllllllo ${providerUserName}");
    if(username != providerUserName){
      String chatRoomId = await getChatRoomId(username!, providerUserName!);
     
      List<String> users = [username ,providerUserName];
      Map<String,dynamic> chatRoomMap={
        "user": users,
        username: userImage,
        providerUserName : providerImageUrl,
        "chatRoomId": chatRoomId
      };

      DatabaseMethod().createChatRoom(chatRoomId, chatRoomMap);
      print("done");
      Navigator.push(context, MaterialPageRoute(builder: 
      (context)=>ConversationScreen
      (chatRoomId: chatRoomId, 
      userName: username,
      imageUrl: userImage!,)));
    }else{
      print("you can not send messege to yourself");
    }
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }


  DatabaseMethod databaseMethod = new DatabaseMethod();


  // ScrollController _scrollController = ScrollController();
  // ScrollController get scrollController => _scrollController;

  Widget chatMessageList(BuildContext context, String userName, String chatRoomId, Stream<QuerySnapshot>? chatStream) {

    return StreamBuilder<QuerySnapshot>(
        stream: chatStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
              // controller: _scrollController,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return MessageTile(
                    message: snapshot.data!.docs[index]["message"],
                    isSendByMe:
                    snapshot.data!.docs[index]["sendby"] == userName);
              })
              : Container();
        });
  }


  sendMessage(String userName, String chatRoomId, TextEditingController msgController) {
    if (msgController.text.isNotEmpty) {
      print("not empty");
      Map<String, dynamic> messageMap = {
        "message": msgController.text,
        "sendby": userName,
        "time": DateTime.now().microsecondsSinceEpoch
      };
      databaseMethod.addConversationMessage(chatRoomId, messageMap);
      msgController.text = "";
    }
  }

  Padding messageList(String name, String email, String image){
    return Padding(
      padding: const EdgeInsets.only(top: 4,bottom: 4),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(left: 2),
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 30,
              backgroundImage: NetworkImage(image),
              child: GestureDetector(onTap: () {}),
            ),
            title: Text(name,style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w600),),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(email,style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(top:20,bottom: 20),
              child: Text('09:21 pm',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
            ),
          ),
          Divider(
            height: 1,
            color: Colors.black,
          ),
        ],
      ),
    );
  }


    

  Widget MessageTile({required final String message, required final bool isSendByMe}) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: isSendByMe ? 0 : 24,
          right: isSendByMe ? 24 : 0),
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: isSendByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: isSendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: isSendByMe ? [
                Color(0xffD9B56B),
                Color(0xffD9B56B)
              ]
                  : [
                Colors.grey.shade500,
                Colors.grey.shade600
              ],
            )
        ),
        child: Text(message,style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }

}