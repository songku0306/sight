class NursingRoomInfo {
  // final String sido;
  // final String sigungu;
  final String sj;
  final String address;
  // final String place;
  final String tel;
  // final String target;
  // final String father;
  // final double lng;
  // final double lat;
  // final String confirmDate;

  NursingRoomInfo({
    required this.tel,
    required this.sj,
    required this.address,
    // required this.place,
    // required this.sido,
    // required this.sigungu,
    // required this.target,
    // required this.father,
    // required this.lng,
    // required this.lat,
    // required this.confirmDate,
  });

  factory NursingRoomInfo.fromJson(Map<String, dynamic> json) {
    return NursingRoomInfo(
      tel: json['tel'],

      sj: json['sj'],
      address: json['address'],
      // place: json['place'],
      // sido: json['sido'],
      // sigungu: json['sigungu'],
      // target: json['target'],
      // father: json['father'],
      // lng: double.parse(json['lng']),
      // lat: double.parse(json['lat']),
      // confirmDate: json['confirm_date'],
    );
  }
}
