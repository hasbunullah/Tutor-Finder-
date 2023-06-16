import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutor_finder/customText/customText.dart';
import 'package:tutor_finder/customText/customText2.dart';

class teachers extends StatelessWidget {
  const teachers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Teachers'),
        backgroundColor: Colors.green.withOpacity(0.5),
      ),
        body: Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.lightGreenAccent,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Name',
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 20.sp,
                            decoration: TextDecoration.none),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('from 2 to 5',
                          style: TextStyle(
                              color: Color(0xff000000).withOpacity(0.5),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none)),
                    ],
                  ),
                ),
              ),
            );
          }),
    ));
  }
}
