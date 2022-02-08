import 'package:json_annotation/json_annotation.dart';

import 'map_point.dart';
part 'map_point_response.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MapPointResponse {
  List<MapPoint> data;
  MapPointResponse({required this.data});
  factory MapPointResponse.fromJson(Map<String, dynamic> json) => _$MapPointResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MapPointResponseToJson(this);

}
