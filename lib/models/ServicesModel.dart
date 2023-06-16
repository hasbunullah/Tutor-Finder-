class ServicesModel {
  String? teacherName;
  String? serviceTime;
  String? servicePrice;
  String? phone;
  String? file;
  String? image;
  int? progress;
  String? userImage;
  String? status;
  String? uId;
  String? subject;
  String? city;
  ServicesModel(
      {this.teacherName,
      this.serviceTime,
      this.servicePrice,
      this.phone,
      this.subject,
      this.file,
      this.image,
      this.progress,
      this.userImage,
      this.status,
      this.uId,
      this.city});

  Map<String, dynamic> toMap() {
    return {
      'teacherName': teacherName,
      'servicesTime': serviceTime,
      'servicePrice': servicePrice,
      'phoneNum': phone,
      'file': file,
      'subject': subject,
      'image': image,
      'userImage': userImage,
      'progress': 0,
      'status': status,
      'UID': uId,
      'city': city,
    };
  }
}
