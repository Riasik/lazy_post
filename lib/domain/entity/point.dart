
import 'package:json_annotation/json_annotation.dart';
part 'point.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class Point{
  int pointNumber;
  double dist;
  double lat;
  double lng;
  String? pointType;
  String area;
  String city;


  Point(this.pointNumber, this.dist, this.lat, this.lng, this.pointType,
      this.area, this.city);

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);
  Map<String, dynamic> toJson() => _$PointToJson(this);
}