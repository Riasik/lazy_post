// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Point _$PointFromJson(Map<String, dynamic> json) => Point(
      json['point_number'] as int,
      (json['dist'] as num).toDouble(),
      (json['lat'] as num).toDouble(),
      (json['lng'] as num).toDouble(),
      json['point_type'] as String?,
      json['area'] as String,
      json['city'] as String,
      json['post_terminal'] as bool,
    );

Map<String, dynamic> _$PointToJson(Point instance) => <String, dynamic>{
      'point_number': instance.pointNumber,
      'dist': instance.dist,
      'lat': instance.lat,
      'lng': instance.lng,
      'point_type': instance.pointType,
      'area': instance.area,
      'city': instance.city,
      'post_terminal': instance.postTerminal,
    };
