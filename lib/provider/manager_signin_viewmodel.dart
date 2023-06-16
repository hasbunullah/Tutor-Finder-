import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutor_finder/screens/AuthWrapper.dart';

import '../models/user_model.dart';

class ManagerSignInViewModel with ChangeNotifier {
  UserModel userModel = UserModel();

  ManagerSignInViewModel() {
    loadLoggedUser();
  }

  Future<void> managerSignIn(   BuildContext context, {UserModel? userModel}) async {
    // final getIt = GetIt.instance;

    try {
      final UserCredential authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: userModel!.email!, password: userModel.password!);

               SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('login', false);

      await loadLoggedUser(user: authResult.user);

      // getIt<UserModel>().userName;

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AuthWrapper()),
          (Route<dynamic> route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("ss${e.toString()}")));
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
    }
  }
}
