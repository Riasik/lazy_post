
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
  bool senderOffice = true;
  bool senderTerminal = true;
  bool receiverOffice = true;
  bool receiverTerminal = true;


  Parcel({
      required this.weight,
      required this.length,
      required this.width,
      required this.height,
       this.volume,
      required this.price,
      required this.senderLat,
      required this.senderLng,
      required this.senderDistance,
      required this.receiverLat,
      required this.receiverLng,
      required this.receiverDistance,
       this.logistic,
      required this.senderOffice,
      required this.senderTerminal,
      required this.receiverOffice,
      required this.receiverTerminal});

  factory Parcel.fromJson(Map<String, dynamic> json) => _$ParcelFromJson(json);
  Map<String, dynamic> toJson() => _$ParcelToJson(this);

}