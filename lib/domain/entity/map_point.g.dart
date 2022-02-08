// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapPoint _$MapPointFromJson(Map<String, dynamic> json) => MapPoint(
      pointNumber: json['point_number'] as int,
      logisticId: json['logistic_id'] as int,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      pointType: json['point_type'] as String?,
      logistic_name: json['logistic_name'] as String?,
      area: json['area'] as String,
      city: json['city'] as String,
      postTerminal: json['post_terminal'] as bool,
      dist: (json['dist'] as num).toDouble(),
    );

Map<String, dynamic> _$MapPointToJson(MapPoint instance) => <String, dynamic>{
      'point_number': instance.pointNumber,
      'dist': instance.dist,
      'logistic_id': instance.logisticId,
      'lat': instance.lat,
      'lng': instance.lng,
      'point_type': instance.pointType,
      'logistic_name': instance.logistic_name,
      'area': instance.area,
      'city': instance.city,
      'post_terminal': instance.postTerminal,
    };
