import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:tutor_finder/chatScreen/UserViewsChat.dart';
import 'package:tutor_finder/screens/teacher/servicesbooked.dart';
import 'package:tutor_finder/screens/teacher/serviceslist.dart';
import 'constant/color_constant.dart';

class BottomBar extends StatefulWidget {
  final int index;
  final int savePrevIndex = 2;
  BottomBar(this.index);

  @override
  State<StatefulWidget> createState() {
    return BottomBar1();
  }
}

class BottomBar1 extends State<BottomBar> {
  ListQueue<int> _navigationQueue = ListQueue();
  int index = 0;
  bool? login = false;

  @override
  Widget build(BuildContext context) {
    // login = PreferenceUtils.getlogin(AppConstant.isLoggedIn);

    return DefaultTabController(
      length: 3,
      initialIndex: widget.index,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            ServicesBookedScreen(),
            ServicesListScreen(),
            UserViewsChat()
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.green.withOpacity(0.6),
                    Colors.green.withOpacity(0.6),
                  ])),
          child: TabBar(
            tabs: [
              const Tab(text: 'Bokking List', icon: Icon(Icons.book)
                  // Container(
                  //     width: 20,
                  //     height: 20,
                  //     child: new SvgPicture.asset(DummyImage.homeWhite)),
                  ),
              const Tab(text: 'Services List', icon: Icon(Icons.design_services)
                  // Container(
                  //     width: 20,
                  //     height: 20,
                  //     child: new SvgPicture.asset(DummyImage.calenderWhite)),
                  ),
              Tab(
                text: 'InBox',
                icon: Container(
                    width: 20,
                    height: 20,
                    child: Icon(Icons.picture_in_picture_sharp)),
              ),
            ],
            labelColor: Colors.blueAccent,
            unselectedLabelColor: blackColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(0.0),
            indicatorColor: whiteColor,
            indicatorWeight: 3.0,
            // indicator: MD2Indicator(
            //   indicatorSize: MD2IndicatorSize.full,
            //   indicatorHeight: 5.0,
            //   indicatorColor: whiteColor,
            // ),
            onTap: (value) {
              _navigationQueue.addLast(index);
              setState(() => index = value);
               },
          ),
        ),
        backgroundColor: Colors.green.withOpacity(0.5),
      ),
    );
  }
}
