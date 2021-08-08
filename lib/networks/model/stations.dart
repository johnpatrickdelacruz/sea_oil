class Station {
  Station.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        code = json["code"],
        mobileNum = json["mobileNum"],
        area = json["area"],
        province = json["province"],
        city = json["city"],
        name = json["name"],
        businessName = json["businessName"],
        address = json["address"],
        lat = json["lat"],
        lng = json["lng"],
        type = json["type"],
        depotId = json["depotId"],
        dealerId = json["dealerId"];

  final int id;
  final String code;
  final String mobileNum;
  final String area;
  final String province;
  final String city;
  final String name;
  final String businessName;
  final String address;
  final String lat;
  final String lng;
  final String type;
  final int depotId;
  final int dealerId;
  double? distance;
}
