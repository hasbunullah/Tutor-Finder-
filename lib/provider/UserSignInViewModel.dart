import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/models/user_model.dart';
import 'package:tutor_finder/provider/widgets_viewmodel.dart';

import '../chatScreen/UserViews.dart';
class UserSignInViewModel with ChangeNotifier {
  UserModel userModel = UserModel();
  bool isAuthenticated = false;

  UserSignInViewModel() {
    loadLoggedUser();
  }

  Future<void> userSignIn(BuildContext context, {UserModel? userModel}) async {
    final widgetProvider =
        Provider.of<WidgetsViewModel>(context, listen: false);
    FirebaseMessaging firebaseMessaging;
    try {
      final UserCredential authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: userModel!.email!, password: userModel.password!);
      isAuthenticated = true;

      await loadLoggedUser(user: authResult.user);

      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => HomeScreen()),
      //     (Route<dynamic> route) => false);
      // Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatRoom()));
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => VerifyEmailPage()));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${e.toString()}")));
    }
    notifyListeners();
  }

  Future<void> loadLoggedUser({User? user}) async {
    User? currentUser;
    if (FirebaseAuth.instance.currentUser != null) {
      currentUser = user ?? FirebaseAuth.instance.currentUser!;
    }
    if (currentUser != null) {
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      userModel = await UserModel.fromDocument(
          documentSnapshot as DocumentSnapshot<Map<String, dynamic>>);
      isAuthenticated = true;

      notifyListeners();
    }
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future logout() async {
    final currentUser = firebaseAuth.currentUser!;
    await firestore
        .collection('users')
        .doc(currentUser.uid)
        .update({'status': "offline"});
    await FirebaseAuth.instance.signOut();
  }

  Future EditProfile(
      {String? titleRole,
      String? subtitleRole,
      String? fulName,
      String? imageUrl,
      String? profilering}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = await _auth.currentUser!;
    final uid = user.uid;

    notifyListeners();
    return FirebaseFirestore.instance.collection("users").doc(uid) 
    
    .update({
      'fullName': fulName,
      'imageUrl': imageUrl,
      'subtitleRole': subtitleRole,
      'titleRole': titleRole,
      'profileRing': profilering,
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    notifyListeners();
    FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = await _auth.currentUser!;
    final uid = user.uid;
    print("uidddddddddddddddddd ${uid.toString()}");
    print("sub Title ${emailControlleruserSearch.toString()}");

    return FirebaseFirestore.instance
        .collection("users")
        // .where("blocked", isNotEqualTo: [uid.toString()])
        // .where("subtitleRole", isEqualTo: selectedCategoryname)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUserHelp() async {
    notifyListeners();
    FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = await _auth.currentUser!;
    final uid = user.uid;
    // print("uidddddddddddddddddd ${userModel.profilering.toString()}");

    return FirebaseFirestore.instance
        .collection("users")
        // .where("subtitleRole", isEqualTo: selectedCategoryname)
        .where("profileRing", isEqualTo: 'help/listen')
        // .where("blocked", arrayContainsAny: [uid.toString()])
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsershare() async {
    notifyListeners();
    // print("uidddddddddddddddddd ${userModel.profilering.toString()}");

    return FirebaseFirestore.instance
        .collection("users")
        // .where("subtitleRole", isEqualTo: selectedCategoryname)
        .where("profileRing", isEqualTo: 'heretosharemystory')
        // .where("blocked", arrayContainsAny: [uid.toString()])
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsersChat(
      String fulname) async {
    notifyListeners();
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("user", arrayContains: fulname)
        .get();
  }
}
