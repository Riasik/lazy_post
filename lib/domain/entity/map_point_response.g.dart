// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_point_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapPointResponse _$MapPointResponseFromJson(Map<String, dynamic> json) =>
    MapPointResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => MapPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MapPointResponseToJson(MapPointResponse instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
