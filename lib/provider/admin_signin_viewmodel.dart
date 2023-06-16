
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/widgets.dart';
import '../base_view_model.dart';
import '../models/admin_model.dart';

class AdminSignInViewModel extends BaseViewModel{

  AdminModel adminModel = AdminModel();

  AdminSignInViewModel() {
    loadLoggedUser();
  }

  Future<void> adminSignIn(BuildContext context) async {

    try {
      final UserCredential authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: adminModel.email!, password: adminModel.password!);

      await loadLoggedUser(user: authResult.user);

      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => ShowUserAndMangerScreen()),
      //         (Route<dynamic> route) => false);


    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("${e.toString()}"))
      );
    }
    notifyListeners();
  }

  void changePassword(String password, BuildContext context) async{
    //Create an instance of the current user.
    User user = await FirebaseAuth.instance.currentUser!;
    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_) async {
    await FirebaseFirestore.instance.collection('admin').doc(user.uid).update(
          {'password': '$password'});
      CustomWidgets().successAwesomeDialog(context, "Password Changed Successfully");

    }).catchError((error){
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  Future<void> loadLoggedUser({User? user}) async {
    User? currentUser;
    if(FirebaseAuth.instance.currentUser != null){
      currentUser = user ?? FirebaseAuth.instance.currentUser!;
    }
    if(currentUser != null) {
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('admin')
          .doc(currentUser.uid).get();
      adminModel = await AdminModel.fromDocument(documentSnapshot as DocumentSnapshot<Map<String, dynamic>>);

      notifyListeners();
    }

  }
}