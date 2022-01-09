import 'package:lazy_post/configuration/configuration.dart';
import 'package:lazy_post/domain/api_client/logistic_api_client.dart';
import 'package:lazy_post/domain/entity/logistic.dart';
import 'package:lazy_post/domain/entity/logistic_response.dart';
import 'package:lazy_post/domain/entity/parcel.dart';

class LogisticService {
  final _logisticApiClient = LogisticApiClient();

  Future<LogisticResponse> logistics(Parcel parcel) =>
    _logisticApiClient.getLogistics(
        Configuration.API_KEY,
        parcel);
}