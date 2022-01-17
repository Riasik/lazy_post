// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parcel _$ParcelFromJson(Map<String, dynamic> json) => Parcel(
      weight: (json['weight'] as num).toDouble(),
      length: (json['length'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      volume: (json['volume'] as num?)?.toDouble(),
      price: (json['price'] as num).toDouble(),
      senderLat: (json['sender_lat'] as num?)?.toDouble(),
      senderLng: (json['sender_lng'] as num?)?.toDouble(),
      senderDistance: (json['sender_distance'] as num?)?.toDouble(),
      receiverLat: (json['receiver_lat'] as num?)?.toDouble(),
      receiverLng: (json['receiver_lng'] as num?)?.toDouble(),
      receiverDistance: (json['receiver_distance'] as num?)?.toDouble(),
      logistic:
          (json['logistic'] as List<dynamic>?)?.map((e) => e as int).toList(),
      senderOffice: json['sender_office'] as bool,
      senderTerminal: json['sender_terminal'] as bool,
      receiverOffice: json['receiver_office'] as bool,
      receiverTerminal: json['receiver_terminal'] as bool,
    );

Map<String, dynamic> _$ParcelToJson(Parcel instance) => <String, dynamic>{
      'weight': instance.weight,
      'length': instance.length,
      'width': instance.width,
      'height': instance.height,
      'volume': instance.volume,
      'price': instance.price,
      'sender_lat': instance.senderLat,
      'sender_lng': instance.senderLng,
      'sender_distance': instance.senderDistance,
      'receiver_lat': instance.receiverLat,
      'receiver_lng': instance.receiverLng,
      'receiver_distance': instance.receiverDistance,
      'logistic': instance.logistic,
      'sender_office': instance.senderOffice,
      'sender_terminal': instance.senderTerminal,
      'receiver_office': instance.receiverOffice,
      'receiver_terminal': instance.receiverTerminal,
    };
