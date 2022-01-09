// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logistic_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogisticResponse _$LogisticResponseFromJson(Map<String, dynamic> json) =>
    LogisticResponse(
      (json['data'] as List<dynamic>)
          .map((e) => Logistic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LogisticResponseToJson(LogisticResponse instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
