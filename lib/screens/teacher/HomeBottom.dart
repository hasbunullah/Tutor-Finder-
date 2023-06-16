import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../bottombar.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new HomeBottom(1),
  ));
}

class HomeBottom extends StatefulWidget {
  // HomeBottom({Key? key}) : super(key: key);
  int index;
  HomeBottom(this.index);
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  @override
  State<HomeBottom> createState() => _HomeBottomState();
}

class _HomeBottomState extends State<HomeBottom> {

 
  String? name = "User";
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      key: _drawerscaffoldkey,
      // drawer: DrawerOnly(),
      bottomNavigationBar: new BottomBar(widget.index),
    ));
  }
}
