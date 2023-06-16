class ServicesModel {
  String? serivesName;
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
  ServicesModel(
      {this.serivesName,
      this.serviceTime,
      this.servicePrice,
      this.phone,
      this.file,
      this.image,
      this.progress,
      this.userImage,
      this.status,
      this.uId,
      this.city});

  Map<String, dynamic> toMap() {
    return {
      'servicesName': serivesName,
      'servicesTime': serviceTime,
      'servicePrice': servicePrice,
      'phoneNum': phone,
      'file': file,
      'image': image,
      'userImage': userImage,
      'progress': 0,
      'status': status,
      'UID': uId,
      'city': city,
    };
  }
}
