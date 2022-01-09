import 'package:json_annotation/json_annotation.dart';
import 'package:lazy_post/domain/entity/logistic.dart';

part 'logistic_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class LogisticResponse{
  List<Logistic> data;
  LogisticResponse(this.data);
  factory LogisticResponse.fromJson(Map<String, dynamic> json) => _$LogisticResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LogisticResponseToJson(this);
}