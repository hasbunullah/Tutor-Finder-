
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/Palette.dart';
import '../provider/widgets_viewmodel.dart';

class CustomWidgets {

  appbar(BuildContext context, String? title) {
    return AppBar(
      title: Text(
        title!,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            children: [

              GestureDetector(
                  onTap: () async {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.INFO,
                      animType: AnimType.BOTTOMSLIDE,
                      title: "Are you sure you want to logout?",
                      // desc: 'Dialog description here.............',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () async {
                        await FirebaseAuth.instance.signOut();
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(builder: (context) => ManagerLoginScreen()),
                        //         (Route<dynamic> route) => false);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Logout Successful"))
                        );
                      },
                    )..show();

                  },
                  child: Icon(Icons.logout)),
              SizedBox(width: 10,),
            ],
          ),
        ),
      ],
      elevation: 0,
    );
  }

  searchBar(String? name) {
    return Container(
      decoration: BoxDecoration(
        // shape: BoxShape.rectangle,
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.grey.shade600),
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextField(
        textAlign: TextAlign.start,
        onChanged: (value){
          name = value;
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'search',
          hintStyle: TextStyle(fontSize: 16),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          prefixIcon: Container(
            padding: EdgeInsets.all(15),
            child: Icon(Icons.search),
            width: 18,
          ),
          filled: true,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }

  Padding iconButton(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          color: Palette().maincolor,
        ),
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: 0,
              bottom: 0,
              child: Icon(
                icon,
                size: 30,
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              // right: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectEndDate(BuildContext context) async {
    final selectedDate = Provider.of<WidgetsViewModel>(context, listen: false);
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),

    );
    if (selected != null && selected != selectedDate.selectedEndDate!) {
      selectedDate.setEndDate(selected);
    }
  }

   successAwesomeDialog(BuildContext context, String text, ){
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: text,
      // desc: 'Dialog description here.............',
      // btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    )..show();
  }

  failedAwesomeDialog(BuildContext context, String text){
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.TOPSLIDE,
      title: text,
      // desc: 'Dialog description here.............',
      // btnCancelOnPress: () {},
      btnCancelOnPress: () {},
    )..show();
  }

}
