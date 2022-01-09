// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logistic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Logistic _$LogisticFromJson(Map<String, dynamic> json) => Logistic(
      json['alias'] as String,
      json['name_ru'] as String,
      json['name_ua'] as String,
      json['logistic_id'] as int,
      json['price'] as int,
      DateTime.parse(json['delivery_date'] as String),
      (json['from'] as List<dynamic>)
          .map((e) => Point.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['to'] as List<dynamic>)
          .map((e) => Point.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LogisticToJson(Logistic instance) => <String, dynamic>{
      'alias': instance.alias,
      'name_ru': instance.nameRu,
      'name_ua': instance.nameUa,
      'logistic_id': instance.logisticId,
      'price': instance.price,
      'delivery_date': instance.deliveryDate.toIso8601String(),
      'from': instance.from.map((e) => e.toJson()).toList(),
      'to': instance.to.map((e) => e.toJson()).toList(),
    };
