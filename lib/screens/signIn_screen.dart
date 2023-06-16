import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/models/user_model.dart';
import 'package:tutor_finder/provider/manager_signin_viewmodel.dart';
import 'package:tutor_finder/provider/widgets_viewmodel.dart';
import 'package:tutor_finder/screens/forgetPassword.dart';
import 'package:tutor_finder/screens/signUp_screen.dart';
import '../custom_button/custom_button.dart';
import '../custom_text_form_field/custom_text_form_field.dart';

class signIn_screen extends StatefulWidget {
  signIn_screen({Key? key}) : super(key: key);

  @override
  State<signIn_screen> createState() => _signIn_screenState();
}

class _signIn_screenState extends State<signIn_screen> {
  final _formKey = GlobalKey<FormState>();
  var _locations = ['Teacher', 'Student'];
  String selectedLocation = 'Student';
  String selectedRole = '';
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;


  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return 
     MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => WidgetsViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => ManagerSignInViewModel(),
          ),
        ],
        child: Consumer2<WidgetsViewModel, ManagerSignInViewModel>(
            builder: (context, widgetProvider, provider, child) =>
    Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.green.withOpacity(0.8),
                  Colors.white,
                  Colors.white,
                  Colors.white,
                  Colors.white,
                  Colors.white,
                  Colors.white,
                  Colors.green.withOpacity(0.8),
                ])),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 38,
            right: 38,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 48,
                  ),
                  child: Image.asset('assets/images/tutor_finder.png',
                      color: Colors.lightGreen, height: 190.h, width: 300.w),
                ),
                Center(
                    child: Text(
                  'Sign In',
                  style: TextStyle(
                      color: Color(0xff82CD47),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                )),
                SizedBox(
                  height: 10.h,
                ),
                Text('Email',
                    style: TextStyle(
                        color: Color(0xff000000).withOpacity(0.5),
                        fontSize: 20.sp,
                        decoration: TextDecoration.none)),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                    height: 45.h,
                    child: custom_text_form_field(
                      validate: MultiValidator([
                        EmailValidator(errorText: 'Enter a valid email address'),
                      ]),
                      obscureText: false,
                      text: 'Enter User Email',
                      controller: emailController,
                    )),
                SizedBox(
                  height: 10.h,
                ),
                Text('Password',
                    style: TextStyle(
                        color: Color(0xff000000).withOpacity(0.5),
                        fontSize: 20.sp,
                        decoration: TextDecoration.none)),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 45.h,
                  child: custom_text_form_field(
                    validate: MultiValidator([
                      RequiredValidator(errorText: 'password is required'),
                      MinLengthValidator(6,
                          errorText: 'password must be at least 6 digits long'),
                    ]),
                    obscureText: obscureText,
                    controller: passwordController,
                    text: 'Enter Password',
                    icon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                // Row(
                //   children: [
                //     Spacer(),
                //     Text('Forget Ppassword?',
                //         style: TextStyle(
                //             color: Color(0xff82CD47).withOpacity(0.8),
                //             fontSize: 14.sp,
                //             decoration: TextDecoration.none)),
                //   ],
                // ),
                // SizedBox(
                //   height: 10.h,
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.green.withOpacity(0.4),
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   height: 45,
                //   width: double.infinity,
                //   child: DropdownButton<String>(
                //     iconEnabledColor: Colors.black,
                //     isExpanded: true,
                //     value: selectedLocation,
                //     icon: const Icon(Icons.arrow_circle_down),
                //     iconSize: 20,
                //     elevation: 16,
                //     underline: Container(),
                //     onChanged: (newValue) {
                //       setState(() {
                //         selectedLocation = newValue!;
                //       });
                //     },
                //     items: List.generate(
                //       _locations.length,
                //       (index) => DropdownMenuItem(
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Text(
                //             _locations[index],
                //           ),
                //         ),
                //         value: _locations[index],
                //       ),
                //     ),
                //   ),
                // ),

                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                    onTap: () {
                      // login();
                        print('serviceeeeeessssss');
                                    // if (_formKey.currentState!.validate()) {
                                    widgetProvider.setCircular(true);
                                    provider.managerSignIn(
                                      context,
                                      userModel: UserModel(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim()),
                                    );

                                    widgetProvider.setCircular(false);
                                    print(
                                        "userName of admin is ${provider.userModel.userName}");

                    },
                    child: custom_button(text: 'Sign In')),
                SizedBox(
                  height: 10.h,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Image.asset('assets/images/mdi_google.png'),
                //     SizedBox(
                //       width: 2.w,
                //     ),
                //     Text('Login with google'),
                //   ],
                // ),
           SizedBox(height: 10.h,),
                GestureDetector(
                    onTap: (){
                      Get.to(ForgetPassword());
                    },
                    child: Text('Forget Password ?',style: TextStyle(color: Colors.blue.withOpacity(0.7)),)),
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 30),
                  child: Row(
                    children: [
                      Text("Don't have any account ? ",
                          style: TextStyle(
                              color: Color(0xff868889).withOpacity(0.8),
                              fontSize: 14.sp,
                              decoration: TextDecoration.none)),
                      GestureDetector(
                        onTap: () {
                          Get.to(signUp_screen(),
                              transition: Transition.size,
                              duration: Duration(seconds: 1));
                        },
                        child: Text('Sign Up',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                decoration: TextDecoration.none)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
  
  ));}
}
