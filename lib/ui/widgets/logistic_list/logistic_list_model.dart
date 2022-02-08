import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_post/domain/api_client/api_client_exception.dart';
import 'package:lazy_post/domain/entity/logistic.dart';
import 'package:lazy_post/domain/entity/parcel.dart';
import 'package:lazy_post/domain/service/logistic_service.dart';
import 'package:lazy_post/ui/navigation/main_navigation.dart';

class LogisticListViewModel extends ChangeNotifier{
  final _logisticService = LogisticService();
  var _logistics = <Logistic>[];
  final Parcel _parcel;
  List<Logistic> get logistics => _logistics;
  //for ui
  bool loading = true;
  String errMessage = '';

  LogisticListViewModel(this._parcel){
    getData();
  }

  String getImageUrl (int logisticId){
    var image = {
      2 : 'images/post/novaposhta.png',
      5 : 'images/post/justin.png',
      6 : 'images/post/meest.png'
    };
    return image[logisticId] ?? 'images/post/dostavka_mvk.png';
  }
  void onLogisticTap(BuildContext context, int index) {
    final data = _logistics[index];
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.searchingResults,
      arguments: data,
    );
  }

  void getData() async{
    try {
      var response = await _logisticService.logistics(_parcel);
      if (response.data.isNotEmpty) {
        _logistics = response.data;
      } else {
        errMessage = 'Не найдено!\nПопробуйте увеличить расстояние.';
      }
    } on ApiClientException catch (e) {
      errMessage = 'Ошибка: $e';
    }
    loading = false;
    _updateState();
  }

  void _updateState() {
    notifyListeners();
  }
}