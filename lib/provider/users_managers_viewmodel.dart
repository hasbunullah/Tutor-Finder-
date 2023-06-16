import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tutor_finder/models/ServicesModel.dart';
import 'package:tutor_finder/models/bookservicesmodel.dart';

class UserManagerViewModel with ChangeNotifier{

  Future<QuerySnapshot<Map<String, dynamic>>> showUsers(){
   final users = FirebaseFirestore.instance.collection("users").where("role", isEqualTo: 'User').get();
    notifyListeners();
    return users;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> showManagers(){
    final managers = FirebaseFirestore.instance.collection("users")
    .where("role", isEqualTo: 'Manager').get();
    notifyListeners();
    return managers;
  }


  assignTask({ServicesModel? taskModel}) {
    FirebaseFirestore.instance.collection('services').add(taskModel!.toMap()).catchError((e) {
      print(e.toString());
    });
  } 
  bookservicesTask({BookServicesModel? taskModell}) {
    FirebaseFirestore.instance.collection('bookservices').add(taskModell!.toMap()).catchError((e) {
      print(e.toString());
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> showManagerTasks(String managerName){
    final tasks = FirebaseFirestore.instance.collection("task")
    .where('managerName', isEqualTo: managerName)
    .get();
    notifyListeners();
    return tasks;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> showUserTasks(String userName, String managerName){
    final tasks = FirebaseFirestore.instance.collection("task").where('userName', isEqualTo: userName).where('managerName', isEqualTo: managerName).get();
    notifyListeners();
    return tasks;
  }

  String? _userImage;
  String? get userImage => _userImage;

  Future<String> getUser(String user) async {
    await FirebaseFirestore.instance.collection('users')
    .where("userName", isEqualTo: user).get().then((snapshot) async {
      _userImage = await snapshot.docs[0].data()["imageUrl"];
      print("this is userImge $_userImage");
      notifyListeners();
    });
    return _userImage!;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> showManagerReviewTask(String state, String managerName){
    final status = FirebaseFirestore.instance.collection("task").where('status', isEqualTo: state).where('managerName', isEqualTo: managerName).get();
    notifyListeners();
    return status;
  }


  Future<QuerySnapshot<Map<String, dynamic>>> showUserReviewTask(String state, String userName){
    final status = FirebaseFirestore.instance.collection("task")
    .where('status', isEqualTo: state).where('userName', isEqualTo: userName).get();
    notifyListeners();
    return status;
  }


  void updateStatus(String id, String status) {
    FirebaseFirestore.instance.collection('task').doc(id).update(
        {'status': '$status'});
    notifyListeners();
  }

}