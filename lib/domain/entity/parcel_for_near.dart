import 'package:flutter/material.dart';
import 'package:lazy_post/ui/widgets/home/home_model.dart';

class ParcelNear {
  double weight;
  double length;
  double width;
  double height;
  double? volume;
  double price;
  double? lat;
  double? lng;
  double? distance;
  List<int>? logistic;
  bool office = true;
  bool terminal = true;

  ParcelNear(
      {required this.weight,
      required this.length,
      required this.width,
      required this.height,
      required this.volume,
      required this.price,
      required this.lat,
      required this.lng,
      required this.distance,
      required this.logistic,
      required this.office,
      required this.terminal});

  factory ParcelNear.fromJson(Map<String, dynamic> j) => ParcelNear(
      weight: j['weight'] as double,
      length: j['length'] as double,
      width: j['width'] as double,
      height: j['height'] as double,
      volume: j['volume'] as double,
      price: j['price'] as double,
      lat: j['lat'] as double,
      lng: j['lng'] as double,
      distance: j['distance'] as double,
      logistic: j['logistic'] as List<int>,
      office: j['office'] as bool,
      terminal: j['terminal'] as bool);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'weight': weight,
        'length': length,
        'width': width,
        'height': height,
        'volume': volume,
        'price': price,
        'lat': lat,
        'lng': lng,
        'distance': distance,
        'logistic': logistic,
        'office': office,
        'terminal': terminal
      };
}
