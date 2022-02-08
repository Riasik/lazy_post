import 'package:json_annotation/json_annotation.dart';

part 'map_point.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MapPoint {
  int pointNumber;
  double dist;
  int logisticId;
  double lat;
  double lng;
  String? pointType;
  String? logistic_name;
  String area;
  String city;
  bool postTerminal;

  MapPoint({
    required this.pointNumber,
    required this.logisticId,
    required this.lat,
    required this.lng,
    required this.pointType,
    required this.logistic_name,
    required this.area,
    required this.city,
    required this.postTerminal,
    required this.dist,
  });

  factory MapPoint.fromJson(Map<String, dynamic> json) => _$MapPointFromJson(json);
  Map<String, dynamic> toJson() => _$MapPointToJson(this);

  // factory MapPoint.fromJson(Map<String, dynamic> json) => MapPoint(
  //   pointNumber: json["point_number"] as int,
  //   logisticId: json["logistic_id"] as int,
  //   lat: json['lat'] as double,
  //   lng: json['lng'] as double ,
  //   pointType: json["point_type"] as String?,
  //   logistic_name: json["logistic_name"] as String?,
  //   area: json["area"] as String,
  //   city: json["city"] as String,
  //   postTerminal: json["post_terminal"] as bool,
  //   dist: json['dist'] as double
  // );
  //
  // Map<String, dynamic> toJson() => <String, dynamic>{
  //   "point_number": pointNumber,
  //   "logistic_id": logisticId,
  //   "lat": lat,
  //   "lng": lng,
  //   "point_type": pointType,
  //   "logistic_name": logistic_name,
  //   "area": area,
  //   "city": city,
  //   "post_terminal": postTerminal,
  //   "dist": dist,
  // };
}