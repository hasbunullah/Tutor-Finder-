class CreateRequestModel {
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
  String? city;
  String? studentUid;
  String? studentName;
  String? subject;
  CreateRequestModel(
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
      this.studentUid,
      this.studentName,
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
      'studentUid': studentUid,
      'studentName': studentName,
      'image': image,
      'userImage': userImage,
      'progress': 0,
      'status': status,
      'UID': uId,
      'city': city,
    };
  }
}
