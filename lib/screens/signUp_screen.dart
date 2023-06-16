import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/models/user_model.dart';
import 'package:tutor_finder/provider/user_signup_viewmodel.dart';
import 'package:tutor_finder/provider/widgets_viewmodel.dart';
import 'package:tutor_finder/screens/signIn_screen.dart';
import '../custom_button/custom_button.dart';
import '../custom_text_form_field/custom_text_form_field.dart';

class signUp_screen extends StatefulWidget {
  signUp_screen({Key? key}) : super(key: key);

  @override
  State<signUp_screen> createState() => _signUp_screenState();
}

class _signUp_screenState extends State<signUp_screen> {
  bool loading = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  final confirmpasswordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  void createUser() async {
    if (emailController.text != '' &&
        passwordController.text != '' &&
        nameController.text != '' &&
        confirmpasswordController.text != '' &&
        passwordController.text == confirmpasswordController.text) {
      try {
        UserCredential credential = await auth.createUserWithEmailAndPassword(
            email: emailController.text.trim().toString(),
            password: passwordController.text.trim().toString());

        if (credential.user != null) {
          Fluttertoast.showToast(
              msg: 'User Added',
              textColor: Colors.white,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              fontSize: 16,
              backgroundColor: Colors.pink,
              timeInSecForIosWeb: 2);
          Get.to(signIn_screen(),
              transition: Transition.size, duration: Duration(seconds: 1));
        }
      } catch (e) {}
      // catch (e) {
      //   Fluttertoast.showToast(
      //       msg: e.toString(),
      //       textColor: Colors.white,
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //       fontSize: 16,
      //       backgroundColor: Colors.pink,
      //       timeInSecForIosWeb: 2);
      // }
    }
    // else if (passwordController.text != confirmpasswordController.text) {
    //   Fluttertoast.showToast(
    //       msg: "Password Does't Matched",
    //       textColor: Colors.white,
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       fontSize: 16,
    //       backgroundColor: Colors.pink,
    //       timeInSecForIosWeb: 2);
    // }
    else {
      Fluttertoast.showToast(
          msg: 'Fill all the fields',
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16,
          backgroundColor: Colors.pink,
          timeInSecForIosWeb: 2);
    }
  }

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => WidgetsViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserSignUpViewModel(),
          ),
        ],
        child: Consumer2<WidgetsViewModel, UserSignUpViewModel>(
            builder: (context, widgetProvider, signUpProvider, child) =>
                Scaffold(
                  backgroundColor: Colors.white,
                  body: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                          Colors.green.withOpacity(0.8),
                          Colors.white,
                          Colors.white,
                          Colors.white,
                          Colors.white,
                          Colors.green.withOpacity(0.8),
                        ])),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 38,
                          right: 38,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                              ),
                              child: Image.asset(
                                  'assets/images/tutor_finder.png',
                                  color: Colors.lightGreen,
                                  height: 150.h,
                                  width: 300.w),
                            ),
                            GestureDetector(
                              onTap: () {
                                widgetProvider.selectGalleryImage();
                                // selectGalleryImage();
                              },
                              child: Center(
                                child: SizedBox(
                                  height: 130,
                                  width: 100,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: CircleAvatar(
                                            radius: 80,
                                            backgroundColor: Colors.white,
                                            child: CircleAvatar(
                                              radius: 75,
                                              backgroundColor:
                                                  Colors.grey.shade400,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.black,
                                                radius: 72,
                                                backgroundImage: widgetProvider
                                                            .imageFile ==
                                                        null
                                                    ? null
                                                    : FileImage(widgetProvider
                                                        .imageFile!),
                                                child: widgetProvider
                                                            .imageFile ==
                                                        null
                                                    ? Icon(
                                                        Icons.person,
                                                        size: 100,
                                                        color: Colors.white70,
                                                      )
                                                    : null,
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Center(
                                child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Color(0xff82CD47),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none),
                            )),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text('Name',
                                style: TextStyle(
                                    color: Color(0xff000000).withOpacity(0.5),
                                    fontSize: 20.sp,
                                    decoration: TextDecoration.none)),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              height: 45.h,
                              child: custom_text_form_field(
                                validate: MultiValidator([
                                  RequiredValidator(errorText: 'Name Required'),
                                ]),
                                obscureText: false,
                                text: 'Jhon David',
                                controller: nameController,
                              ),
                            ),
                            Text('phone',
                                style: TextStyle(
                                    color: Color(0xff000000).withOpacity(0.5),
                                    fontSize: 20.sp,
                                    decoration: TextDecoration.none)),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              height: 45.h,
                              child: custom_text_form_field(
                                validate: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'phone Required'),
                                  MinLengthValidator(11,
                                      errorText:
                                      '11 digit Phone number'),
                                ]),
                                obscureText: false,
                                text: '03123******',
                                type: TextInputType.number,
                                controller: phoneController,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text('Email',
                                style: TextStyle(
                                    color: Color(0xff000000).withOpacity(0.5),
                                    fontSize: 20.sp,
                                    decoration: TextDecoration.none)),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              height: 45.h,
                              child: custom_text_form_field(
                                validate: MultiValidator([
                                  EmailValidator(
                                      errorText: 'Enter a valid email address'),
                                  RequiredValidator(
                                      errorText: 'Email Required'),
                                ]),
                                obscureText: false,
                                controller: emailController,
                                text: 'bunny@gmail.com',
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text('Password',
                                style: TextStyle(
                                    color: Color(0xff000000).withOpacity(0.5),
                                    fontSize: 20.sp,
                                    decoration: TextDecoration.none)),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              height: 45.h,
                              child: custom_text_form_field(
                                  validate: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'password is required'),
                                    MinLengthValidator(6,
                                        errorText:
                                            'password must be at least 6 digits long'),
                                  ]),
                                  obscureText: obscureText,
                                  controller: passwordController,
                                  text: '.............',
                                  icon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                    child: Icon(
                                      obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.green,
                                    ),
                                  )),
                            ),
                            Text('Confirm Password',
                                style: TextStyle(
                                    color: Color(0xff000000).withOpacity(0.5),
                                    fontSize: 20.sp,
                                    decoration: TextDecoration.none)),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              height: 45.h,
                              child: custom_text_form_field(
                                  validate: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'password is required'),
                                    MinLengthValidator(6,
                                        errorText:
                                            'password must be at least 6 digits long'),
                                  ]),
                                  obscureText: obscureText,
                                  controller: confirmpasswordController,
                                  text: '.............',
                                  icon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                    child: Icon(
                                      obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.green,
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
                                height:
                                    MediaQuery.of(context).size.height * .075,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Colors.amber,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        width: 200,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            iconEnabledColor: Colors.blueAccent,
                                            iconDisabledColor: Colors.amber,
                                            isExpanded: true,
                                            value: widgetProvider.userManager,
                                            items: widgetProvider.dropdownItems,
                                            onChanged: (value) {
                                              widgetProvider.setUserManager(
                                                  value.toString());
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  // createUser();
                                  // if (_formKey.currentState!
                                  //     .validate()) {
                                  widgetProvider.setCircular(true);
                                  await widgetProvider.uploadImage(context);
                                  // ignore: use_build_context_synchronously
                                  signUpProvider.userSignUp(context,
                                      userModel: UserModel(
                                          role: widgetProvider.userManager,
                                          email: emailController.text.trim(),
                                          imageUrl:
                                              widgetProvider.imageUrlDownload,
                                          password:
                                              passwordController.text.trim(),
                                          phoneNo: phoneController.text.trim(),
                                          userName: nameController.text.trim(),
                                          fcmToken: 'dsds',
                                          // city: widgetProvider.usercity,
                                          uID: ''));
                                  print('singuoppppppp');
                                  widgetProvider.setCircular(false);
                                  // }
                                  print('onpresssssssssssssssssssssssssss');
                                },
                                child: loading
                                    ? CircularProgressIndicator()
                                    : custom_button(text: 'Sign Up'),),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have any account ? ",
                                    style: TextStyle(
                                        color:
                                            Color(0xff868889).withOpacity(0.8),
                                        fontSize: 14.sp,
                                        decoration: TextDecoration.none)),
                                InkWell(
                                  onTap: () {
                                    Get.off(signIn_screen());
                                  },
                                  child: Text('Sign In',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
  }
}
