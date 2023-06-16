class BookServicesModel {
  String? haircutm;
  String? bearedm;
  String? trimmingm;
  String? skincarem;
  String? facialm;
  String? treatmentm;
  String? maskm;
  String? curem;
  String? othersm;
  String? servicetimem;
  String? servicedatem;
  String? status;
  String? providerUID;
  String? myUid;

  BookServicesModel(
      {this.haircutm,
      this.bearedm,
      this.trimmingm,
      this.skincarem,
      this.facialm,
      this.treatmentm,
      this.maskm,
      this.curem,
      this.othersm,
      this.servicetimem,
      this.servicedatem,
      this.status,
      this.providerUID,
      this.myUid});

  Map<String, dynamic> toMap() {
    return {
      'haircut': haircutm,
      'beared': bearedm,
      'trimming': trimmingm,
      'skincare': skincarem,
      'facial': facialm,
      'treatment': treatmentm,
      'mask': maskm,
      'cure': curem,
      'servicetime': servicetimem,
      'serviceDate': servicedatem,
      'others': othersm,
      'status': status,
      'providerUid': providerUID,
      'myUid': myUid,
    };
  }
}
