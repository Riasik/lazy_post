
import 'package:json_annotation/json_annotation.dart';
part 'parcel.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Parcel{
  double weight;
  double length;
  double width;
  double height;
  double? volume;
  double price;
  double? senderLat;
  double? senderLng;
  double? senderDistance;
  double? receiverLat;
  double? receiverLng;
  double? receiverDistance;
  List<int>? logistic;


  Parcel({
      required this.weight,
      required this.length,
      required this.width,
      required this.height,
      required this.price,
      required this.senderLat,
      required this.senderLng,
      required this.receiverLat,
      required this.receiverLng,
      this.senderDistance,
      this.receiverDistance,
      this.volume,
      this.logistic});

  factory Parcel.fromJson(Map<String, dynamic> json) => _$ParcelFromJson(json);
  Map<String, dynamic> toJson() => _$ParcelToJson(this);

}