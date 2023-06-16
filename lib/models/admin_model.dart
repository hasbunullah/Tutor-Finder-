import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {

  AdminModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> documentSnapshot){
    id = documentSnapshot.id;
    email = documentSnapshot.data()!['email'];
    imageUrl = documentSnapshot.data()!['imageUrl'];
    userName = documentSnapshot.data()!['userName'];
    password = documentSnapshot.data()!['password'];
    phoneNo = documentSnapshot.data()!['phoneNo'];
  }

  String? email;
  String? imageUrl;
  String? userName;
  String? id;
  String? password;
  String? phoneNo;

  AdminModel({
    this.email,
    this.imageUrl,
    this.id,
    this.password,
    this.phoneNo,
    this.userName
  });

  DocumentReference get firestoreRef => FirebaseFirestore.instance.doc('admin/$id');

  Future<void> saveInfo() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'imageUrl': imageUrl,
      'userName': userName,
      'password': password,
      'phoneNo': phoneNo,
    };
  }
}