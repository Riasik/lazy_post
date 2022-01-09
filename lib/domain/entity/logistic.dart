import 'package:json_annotation/json_annotation.dart';
import 'package:lazy_post/domain/entity/point.dart';

part 'logistic.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Logistic{
  Logistic(this.alias, this.nameRu, this.nameUa, this.logisticId,
      this.price, this.deliveryDate, this.from, this.to);
  String alias;
  String nameRu;
  String nameUa;
  int logisticId;
  int price;
  DateTime deliveryDate;
  List<Point> from;
  List<Point> to;

  factory Logistic.fromJson(Map<String, dynamic> json) => _$LogisticFromJson(json);
  Map<String, dynamic> toJson() => _$LogisticToJson(this);

}