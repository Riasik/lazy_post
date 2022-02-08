import 'package:lazy_post/configuration/configuration.dart';
import 'package:lazy_post/domain/entity/logistic.dart';
import 'package:lazy_post/domain/entity/logistic_response.dart';
import 'package:lazy_post/domain/entity/map_point.dart';
import 'package:lazy_post/domain/entity/parcel.dart';
import 'package:lazy_post/domain/entity/parcel_for_near.dart';

import '../entity/map_point_response.dart';
import 'network_client.dart';

class LogisticApiClient{

  final _networkClient = NetworkClient();

  Future<LogisticResponse> getLogistics(String apiKey,Parcel parcel){
    LogisticResponse parser(dynamic json){
      final jsonMap = json as Map<String, dynamic>;
      final response = LogisticResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.post(
      '/logistic/getLogistics',
      <String, dynamic>{
        'apiKey': Configuration.API_KEY,
        'data': parcel.toJson(),
      },
      parser
    );
    return result;
  }

  Future<MapPointResponse> getNearPoints(String apiKey,ParcelNear parcel){
    MapPointResponse parser(dynamic json){
      final jsonMap = json as Map<String, dynamic>;
      final response = MapPointResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.post(
      '/logistic/getNearPoints',
      <String, dynamic>{
        'apiKey': Configuration.API_KEY,
        'data': parcel.toJson(),
      },
      parser
    );
    return result;
  }
}