import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/models/ServicesModel.dart';

import '../../../Widgets/widgets.dart';
import '../../../constant/color_constant.dart';
import '../../../constant/constant_font.dart';
import '../../../constant/string_constant.dart';
import '../../../provider/users_managers_viewmodel.dart';
import '../../../provider/widgets_viewmodel.dart';

class CreateServices extends StatefulWidget {
  CreateServices({Key? key}) : super(key: key);

  @override
  State<CreateServices> createState() => _CreateServicesState();
}

File? _imageFile;
File? get imageFile => _imageFile;
XFile? image;
ImagePicker _picker = ImagePicker();
String? Function(String?)? validate;

class _CreateServicesState extends State<CreateServices> {
  String? _name, _image, _price, _serivcesTime, _phone = "";
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _imageFocusNode = FocusNode();
  FocusNode _priceFocusNode = FocusNode();
  FocusNode _serivcesTimeFocusNode = FocusNode();
  FocusNode _phoneTimeFocusNode = FocusNode();

  TextEditingController _servicesNameController = TextEditingController();
  TextEditingController _servicespriceController = TextEditingController();
  TextEditingController _servicesTimeController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final User currentUser = FirebaseAuth.instance.currentUser!;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => WidgetsViewModel()),
          ChangeNotifierProvider(create: (context) => UserManagerViewModel()),
        ],
        child: Consumer2<WidgetsViewModel, UserManagerViewModel>(
            builder: (context, widgetProvider, userProvider, child) => SafeArea(
                    child: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        color: blackColor,
                        size: 30,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text(
                      StringConstant.createNewServies,
                      style: TextStyle(
                          color: blackColor,
                          fontFamily: ConstantFont.montserratBold,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.green.withOpacity(0.5),
                    elevation: 0.0,
                  ),
                  body: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white,
                              Colors.green.withOpacity(0.6),
                            ])),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // showDialog(
                              //     context: context,
                              //     builder: (BuildContext context) {
                              //       return AlertDialog(
                              //         backgroundColor: Palette.primary,
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius:
                              //               BorderRadius.circular(35.0),
                              //         ),
                              //         title: Text(
                              //           'Choose Option',
                              //           style: TextStyle(
                              //             fontWeight: FontWeight.w600,
                              //           ),
                              //         ),
                              //         content: SingleChildScrollView(
                              //           child: ListBody(
                              //             children: [
                              //               InkWell(
                              //                 onTap: () {
                              //                   widgetProvider
                              //                       .selectCameraImage();
                              //                 },
                              //                 // splashColor: Palette.facebookColor,
                              //                 child: Row(
                              //                   children: [
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets
                              //                               .all(8.0),
                              //                       child: Icon(
                              //                         Icons.camera,
                              //                       ),
                              //                     ),
                              //                     Text(
                              //                       'Camera',
                              //                       style: TextStyle(
                              //                           fontSize: 18,
                              //                           fontWeight:
                              //                               FontWeight
                              //                                   .bold),
                              //                     )
                              //                   ],
                              //                 ),
                              //               ),
                              //               InkWell(
                              //                 onTap: () {
                              //                   widgetProvider
                              //                       .selectGalleryImage();
                              //                 },
                              //                 // splashColor: Palette.facebookColor,
                              //                 child: Row(
                              //                   children: [
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets
                              //                               .all(8.0),
                              //                       child: Icon(
                              //                         Icons.image,
                              //                       ),
                              //                     ),
                              //                     Text(
                              //                       'Gallery',
                              //                       style: TextStyle(
                              //                           fontSize: 18,
                              //                           fontWeight:
                              //                               FontWeight
                              //                                   .bold),
                              //                     )
                              //                   ],
                              //                 ),
                              //               ),
                              //               InkWell(
                              //                 onTap: () {},
                              //                 // splashColor: Palette.facebookColor,
                              //                 child: Row(
                              //                   children: [
                              //                     Padding(
                              //                       padding:
                              //                           const EdgeInsets
                              //                               .all(8.0),
                              //                       child: Icon(
                              //                         Icons.remove_circle,
                              //                       ),
                              //                     ),
                              //                     Text(
                              //                       'Remove',
                              //                       style: TextStyle(
                              //                           fontSize: 18,
                              //                           color: Colors.red,
                              //                           fontWeight:
                              //                               FontWeight
                              //                                   .bold),
                              //                     )
                              //                   ],
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       );
                              //     });

                              widgetProvider.selectGalleryImage();
                            },
                            child: Container(
                              height: size.height * .3,
                              width: size.width,
                              child: Stack(
                                children: [
                                  Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        radius: 80,
                                        backgroundColor: Colors.green.withOpacity(0.5),
                                        child: CircleAvatar(
                                          radius: 75,
                                          backgroundColor: Colors.green.withOpacity(0.5),
                                          child: CircleAvatar(
                                            backgroundColor: blackColor,
                                            radius: 72,
                                            backgroundImage: widgetProvider
                                                        .imageFile ==
                                                    null
                                                ? null
                                                : FileImage(
                                                    widgetProvider.imageFile!),
                                            child:
                                                widgetProvider.imageFile == null
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
                          Container(
                            child: Container(
                              margin: const EdgeInsets.only(top: 5.0, left: 35.0),
                              alignment: FractionalOffset.topLeft,
                              child: Text(
                                StringConstant.Teachername,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: grey99,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: ConstantFont.montserratMedium),
                              ),
                            ),
                          ),
                          Container(
                            height: 45,
                            alignment: FractionalOffset.topLeft,
                            margin: const EdgeInsets.only(
                                top: 5.0, left: 20.0, right: 20.0, bottom: 15),
                            child: TextFormField(
                              autofocus: true,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              controller: _servicesNameController,
                              // validator: (name) {
                              //   Pattern pattern =
                              //       r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                              //   RegExp regex = new RegExp(pattern as String);
                              //   if (!regex.hasMatch(name!))
                              //     return 'Invalid username';
                              //   else
                              //     return null;
                              // },
                              validator:  MultiValidator([
                                RequiredValidator(errorText: 'Name Required'),
                              ]),
                              onSaved: (name) => _name = name,
                              onFieldSubmitted: (_) {
                                fieldFocusChange(
                                    context, _nameFocusNode, _nameFocusNode);
                              },
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: ConstantFont.montserratMedium),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: whiteF1,
                                hintText: 'Enter your Name',
                                hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: ConstantFont.montserratMedium),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: whiteF1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: whiteF1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5.0, left: 35.0),
                            alignment: FractionalOffset.topLeft,
                            child: Text(
                              'City',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: grey99,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: ConstantFont.montserratMedium),
                            ),
                          ),
                          Container(
                            height: 45,
                            alignment: FractionalOffset.topLeft,
                            margin: const EdgeInsets.only(
                                top: 5.0, left: 20.0, right: 20.0, bottom: 15),
                            child: TextFormField(
                              autofocus: true,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              controller: _cityController,
                              validator: (name) {
                                Pattern pattern =
                                    r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                RegExp regex = new RegExp(pattern as String);
                                if (!regex.hasMatch(name!))
                                  return 'Invalid username';
                                else
                                  return null;
                              },
                              onSaved: (name) => _name = name,
                              onFieldSubmitted: (_) {
                                fieldFocusChange(
                                    context, _nameFocusNode, _nameFocusNode);
                              },
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: ConstantFont.montserratMedium),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: whiteF1,
                                hintText: 'Enter your City',
                                hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: ConstantFont.montserratMedium),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: whiteF1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: whiteF1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5.0, left: 35.0),
                            alignment: FractionalOffset.topLeft,
                            child: Text(
                              StringConstant.servicesprice,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: grey99,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: ConstantFont.montserratMedium),
                            ),
                          ),
                          Container(
                            height: 45,
                            alignment: FractionalOffset.topLeft,
                            margin: const EdgeInsets.only(
                                top: 5.0, left: 20.0, right: 20.0, bottom: 15),
                            child: TextFormField(
                              autofocus: true,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              controller: _servicespriceController,
                              validator: (name) {
                                Pattern pattern =
                                    r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                RegExp regex = new RegExp(pattern as String);
                                if (!regex.hasMatch(name!))
                                  return 'Invalid price';
                                else
                                  return null;
                              },
                              onSaved: (name) => _name = name,
                              onFieldSubmitted: (_) {
                                fieldFocusChange(
                                    context, _priceFocusNode, _priceFocusNode);
                              },
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: ConstantFont.montserratMedium),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: whiteF1,
                                hintText: 'Enter your Service price',
                                hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: ConstantFont.montserratMedium),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: whiteF1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: whiteF1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Container(
                              margin: const EdgeInsets.only(top: 5.0, left: 35.0),
                              alignment: FractionalOffset.topLeft,
                              child: Text(
                                StringConstant.servicestime,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: grey99,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: ConstantFont.montserratMedium),
                              ),
                            ),
                          ),
                          Container(
                            height: 45,
                            alignment: FractionalOffset.topLeft,
                            margin: const EdgeInsets.only(
                                top: 5.0, left: 20.0, right: 20.0, bottom: 15),
                            child: TextFormField(
                              autofocus: true,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              controller: _servicesTimeController,
                              validator: (name) {
                                Pattern pattern =
                                    r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                RegExp regex = new RegExp(pattern as String);
                                if (!regex.hasMatch(name!))
                                  return 'Invalid time';
                                else
                                  return null;
                              },
                              onSaved: (name) => _name = name,
                              onFieldSubmitted: (_) {
                                fieldFocusChange(context, _serivcesTimeFocusNode,
                                    _serivcesTimeFocusNode);
                              },
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: ConstantFont.montserratMedium),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: whiteF1,
                                hintText: 'Enter your Serives Time',
                                hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: ConstantFont.montserratMedium),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: whiteF1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: whiteF1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Container(
                              margin: const EdgeInsets.only(top: 5.0, left: 35.0),
                              alignment: FractionalOffset.topLeft,
                              child: Text(
                                StringConstant.phoneNumber,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: grey99,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: ConstantFont.montserratMedium),
                              ),
                            ),
                          ),
                          Container(
                            height: 45,
                            alignment: FractionalOffset.topLeft,
                            margin: const EdgeInsets.only(
                                top: 5.0, left: 20.0, right: 20.0, bottom: 15),
                            child: TextFormField(
                              autofocus: true,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              controller: _phoneController,
                              onFieldSubmitted: (_) {
                                fieldFocusChange(
                                    context, _nameFocusNode, _nameFocusNode);
                              },
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: ConstantFont.montserratMedium),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: whiteF1,
                                hintText: 'Enter your Phone Number',
                                hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: ConstantFont.montserratMedium),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: whiteF1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: whiteF1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
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
                                  value: widgetProvider.userManagersubject,
                                  items: widgetProvider.dropdownsubeject,
                                  onChanged: (value) {
                                    widgetProvider
                                        .setUserManagersubject(value.toString());
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: MaterialButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10)),
                              height: 45,
                              color: Colors.green.withOpacity(0.5),
                              onPressed: () async {
                                //  if (_formKey.currentState!.validate()) {
                                widgetProvider.setCircular(true);
                                await widgetProvider.uploadImage(context);
                                // await userProvider
                                //     .getUser(widgetProvider.selectUser);
                                print(
                                    "this is user image provided ${userProvider.userImage}");

                                userProvider.assignTask(
                                    taskModel: ServicesModel(
                                        teacherName:
                                            _servicesNameController.text.trim(),
                                        serviceTime:
                                            _servicesTimeController.text.trim(),
                                        servicePrice:
                                            _servicespriceController.text.trim(),
                                        phone: _phoneController.text.trim(),
                                        file: widgetProvider.fileUrlDownload,
                                        image: widgetProvider.imageUrlDownload,
                                        userImage: userProvider.userImage,
                                        uId: currentUser.uid,
                                        subject: widgetProvider.userManagersubject,
                                        city: _cityController.text.trim()));
                                // print('sender Token $senderToken');
                                // makePostRequest("Dijilla", "you received a new task",
                                //     senderToken!);
                                widgetProvider.setCircular(false);
                                CustomWidgets().successAwesomeDialog(
                                    context, "Task created Successfully");
                              },

                              // }
                              child: Text(
                                StringConstant.upload,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: ConstantFont.montserratMedium,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))));
  }

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void selectGalleryImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    _imageFile = File(image!.path);
  }
}
