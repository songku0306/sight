class NursingRoom {
  final String sido;
  final String sigungu;
  final String sj;
  final String address;
  final String place;
  final String tel;
  final String target;
  final String father;
  final String lng;
  final String lat;
  final String confirmDate;

  NursingRoom({
    required this.sido,
    required this.sigungu,
    required this.sj,
    required this.address,
    required this.place,
    required this.tel,
    required this.target,
    required this.father,
    required this.lng,
    required this.lat,
    required this.confirmDate,
  });

  factory NursingRoom.fromJson(Map<String, dynamic> json) {
    return NursingRoom(
      sido: json['sido'],
      sigungu: json['sigungu'],
      sj: json['sj'],
      address: json['address'],
      place: json['place'],
      tel: json['tel'],
      target: json['target'],
      father: json['father'],
      lng: json['lng'],
      lat: json['lat'],
      confirmDate: json['confirm_date'],
    );
  }
}
