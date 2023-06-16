import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:tutor_finder/models/user_model.dart';

class WidgetsViewModel with ChangeNotifier {
  bool _circular = false;
  bool get circular => _circular;
  UserModel userModel = UserModel();

  void setCircular(bool circular) {
    _circular = circular;
    notifyListeners();
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("student"), value: "student"),
      DropdownMenuItem(child: Text("teachers"), value: "teachers"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownsubeject {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("English"), value: "English"),
      DropdownMenuItem(child: Text("Mathematics"), value: "Mathematics"),
      DropdownMenuItem(child: Text("Physics"), value: "Physics"),
      DropdownMenuItem(child: Text("Chemistry"), value: "Chemistry"),
      DropdownMenuItem(child: Text("Urdu"), value: "Urdu"),
      DropdownMenuItem(child: Text("Computer"), value: "Computer"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsHair {
    List<DropdownMenuItem<String>> menuItemshair = [
      DropdownMenuItem(child: Text("hair"), value: "hair"),
      DropdownMenuItem(child: Text("beared"), value: "beared"),
      DropdownMenuItem(child: Text("trimming"), value: "trimming"),
    ];
    return menuItemshair;
  }

  List<DropdownMenuItem<String>> get dropdownItemscity {
    List<DropdownMenuItem<String>> menuItemscity = [
      DropdownMenuItem(child: Text("Peshawar"), value: "Peshawar"),
      DropdownMenuItem(child: Text("Lahore"), value: "lahore"),
      DropdownMenuItem(child: Text("Faisalabad"), value: "Faisalabad"),
      DropdownMenuItem(child: Text("Rawalpindi"), value: "Rawalpindi"),
      DropdownMenuItem(child: Text("Multan"), value: "Multan"),
      DropdownMenuItem(child: Text("Gujranwala"), value: "Gujranwala"),
      DropdownMenuItem(child: Text("Hyderabad"), value: "Hyderabad"),
      DropdownMenuItem(child: Text("Quetta"), value: "Quetta"),
    ];
    return menuItemscity;
  }

  String _usercity = "Peshawar";
  String get usercity => _usercity;

  void setUsercity(String usercity) {
    _usercity = usercity;
    notifyListeners();
  }

  Color? _color;
  Color? get color => _color;

  void setColor(Color color) {
    _color = color;
    notifyListeners();
  }

  String _userManagersubject = "English";
  String get userManagersubject => _userManagersubject;

  void setUserManagersubject(String userManagersubject) {
    _userManagersubject = userManagersubject;
    notifyListeners();
  }

  String _userManager = "student";
  String get userManager => _userManager;

  void setUserManager(String userManager) {
    _userManager = userManager;
    notifyListeners();
  }

  String _userHair = "hair";
  String get userhair => _userHair;

  void setUserHair(String userhair) {
    _userHair = userhair;
    notifyListeners();
  }

  File? _imageFile;
  File? get imageFile => _imageFile;

  void selectGalleryImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    _imageFile = File(image!.path);
    notifyListeners();
  }

  void selectCameraImage() async {
    image = await _picker.pickImage(source: ImageSource.camera);
    _imageFile = File(image!.path);
    notifyListeners();
  }

  String? _imageUrlDownload;
  String? get imageUrlDownload => _imageUrlDownload;

  XFile? image;
  ImagePicker _picker = ImagePicker();
  Reference? task;

  Future uploadImage(BuildContext context) async {
    if (imageFile == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please Upload your Picture")));
      _circular = false;
      notifyListeners();
    }

    String imageName = basename(_imageFile!.path);
    final destination = 'users/images/$imageName';
    task = FirebaseStorage.instance.ref(destination);

    await task!.putFile(File(imageFile!.path));
    _imageUrlDownload = await task!.getDownloadURL();
    print('Download-link: $imageUrlDownload');
  }

  int _toggleButton = 0;
  int get toggleButton => _toggleButton;

  void setToggleButton(int toggleButton) {
    _toggleButton = toggleButton;
    notifyListeners();
  }

  // String _selectedStartDate = "";
  // String? get selectedStartDate => _selectedStartDate;
  //
  // void setStartDate(){
  //   String formattedDate = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  //   _selectedStartDate = formattedDate;
  //   notifyListeners();
  // }

  String _selectedEndDate = "";
  String? get selectedEndDate => _selectedEndDate;

  void setEndDate(DateTime selectedEndDate) {
    String formattedDate = DateFormat('dd-MMM-yyyy').format(selectedEndDate);
    _selectedEndDate = formattedDate;
    notifyListeners();
  }

  String _selectUser = "";
  String get selectUser => _selectUser;

  void setSelectUser(String selectUser) {
    _selectUser = selectUser;
    notifyListeners();
  }

  String _selectPriority = "Low";
  String get selectPriority => _selectPriority;

  void setPriority(String selectPriority) {
    _selectPriority = selectPriority;
    notifyListeners();
  }

  //
  // List<File>? _files;
  // List<File>? get files => _files;
  //
  // List<String>? _filesName;
  // List<String>? get filesName => _filesName;
  //
  // void filesPicker() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
  //   if (result != null) {
  //     _files = result.paths.map((path) => File(basename(path!))).toList();
  //     _files?.forEach((element) {
  //       _filesName?.add(element.toString());
  //     });
  //   } else {
  //     // User canceled the picker
  //   }
  //   notifyListeners();
  // }
  //
  // String? _filesUrlDownload;
  // String? get filesUrlDownload => _filesUrlDownload;
  // Reference? task1;
  //
  // Future uploadFiles(BuildContext context) async {
  //   if(_files == null) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Please Upload your file")));
  //   }
  //   final destination = 'users/files/$_filesName';
  //   task2 = FirebaseStorage.instance.ref(destination);
  //
  //   await task2!.putFile(File(_imageFile!.path));
  //   _fileUrlDownload = await task2!.getDownloadURL();
  //   print('Download-link: $imageUrlDownload');
  // }

  File? _file;
  File? get file => _file;

  String? _fileName;
  String? get fileName => _fileName;

  void filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _file = File(result.files.single.path!);
      _fileName = basename(_file!.path);
    } else {
      // User canceled the picker
    }
    notifyListeners();
  }

  String? _fileUrlDownload;
  String? get fileUrlDownload => _fileUrlDownload;
  Reference? task2;

  Future uploadFile(BuildContext context) async {
    if (_file == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please Upload your file")));
    }
    final destination = 'users/files/$_fileName';
    task2 = FirebaseStorage.instance.ref(destination);

    await task2!.putFile(File(_imageFile!.path));
    _fileUrlDownload = await task2!.getDownloadURL();
    print('Download-link: $imageUrlDownload');
  }

  int _bottomNavIndex = 0;
  int get bottomNavIndex => _bottomNavIndex;

  void setBottomNav(int bottomNavIndex) {
    _bottomNavIndex = bottomNavIndex;
    notifyListeners();
  }

  // Stream<QuerySnapshot>? _chatMessageStream;
  // Stream<QuerySnapshot>? get chatMessageStream => _chatMessageStream;
  //
  // void setChatStream(Stream<QuerySnapshot> chatMessageStream){
  //   _chatMessageStream = chatMessageStream;
  //   notifyListeners();
  // }

  PageController? _pageController;
  PageController? get pageController => _pageController;

  void setPageController() {
    _pageController = PageController(initialPage: 2);
    notifyListeners();
  }
}
