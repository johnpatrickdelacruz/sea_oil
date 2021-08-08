import 'package:sea_oil/networks/model/stations.dart';

class StationResponse {
  StationResponse(
    this.stations,
    this.status,
  );

  StationResponse.fromJson(Map<String, dynamic> json)
      : stations =
            (json["data"] as List).map((i) => Station.fromJson(i)).toList(),
        status = json["status"];

  final List<Station> stations;

  final String status;
}
