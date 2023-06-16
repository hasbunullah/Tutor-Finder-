import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tutor_finder/screens/signIn_screen.dart';
import 'package:tutor_finder/screens/signUp_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: SafeArea(
            child: AnimatedSplashScreen(
              splash: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(60, 20, 60, 0),
                      child: Image.asset(
                        'assets/images/tutor_finder.png',color: Colors.lightGreen,
                        fit: BoxFit.fitWidth,
                        width: 270.w,
                        height: 150.h,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                      child: Image.asset(
                        'assets/images/splashScreen.png',
                        fit: BoxFit.fitWidth,
                        width: 270.w,
                        height: 350.h,
                      ),
                    ),
                    Text(
                      'Find your best tutor',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.grey,
                          fontSize: 30.sp), // Set this
                    ),
                    Text(
                      'to reach your goals',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.grey,
                          fontSize: 20.sp), // Set this
                    ),
                  ],
                ),
              ),
              nextScreen:
              // FirebaseAuth.instance.currentUser==null?
              signIn_screen(),
              //: subjects(),

              splashIconSize: double.infinity,
              splashTransition: SplashTransition.fadeTransition,
            ),
          ),
        );
      },
    ),
  );
}
