import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/widgets.dart';
import '../models/user_model.dart';

class UserSignUpViewModel with ChangeNotifier{

  UserModel userModel = UserModel();



  Future<void> userSignUp(BuildContext context, {UserModel? userModel}) async {

    try {
      final UserCredential authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: userModel!.email!, password: userModel.password!);

      userModel.id = authResult.user!.uid;

      await userModel.saveInfo();

      await loadLoggedUser(user: authResult.user);
      CustomWidgets().successAwesomeDialog(context, 'Successfully User Added', );

  // Navigator.of(context).pushAndRemoveUntil(
  //                                   MaterialPageRoute(
  //                                       builder: (context) => LoginScreenServies()),
  //                                   (context) => false);
      // Navigator.pop(context, false);

    } catch (e) {
      CustomWidgets().failedAwesomeDialog(context, e.toString());
    }
    notifyListeners();
  }

  Future<void> loadLoggedUser({User? user}) async {
    final User currentUser = user ?? FirebaseAuth.instance.currentUser!;
    if(currentUser != null) {
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('users')
          .doc(currentUser.uid).get();
      userModel = await UserModel.fromDocument(documentSnapshot as DocumentSnapshot<Map<String, dynamic>>);

      notifyListeners();
    }

  }
}