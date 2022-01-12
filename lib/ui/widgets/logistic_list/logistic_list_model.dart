import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_post/domain/entity/logistic.dart';
import 'package:lazy_post/ui/navigation/main_navigation.dart';

class LogisticListViewModel extends ChangeNotifier{
  var _logistics = <Logistic>[];
  List<Logistic> get logistics => _logistics;
  LogisticListViewModel(this._logistics);

  String getImageUrl (int logisticId){
    var image = {
      2 : 'images/novaposhta.png',
      5 : 'images/justin.png',
      6 : 'images/meest.png'
    };
    return image[logisticId] ?? 'images/dostavka_mvk.png';
  }
  void onLogisticTap(BuildContext context, int index) {
    final data = _logistics[index];
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.searchingResults,
      arguments: data,
    );
  }
}