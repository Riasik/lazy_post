import 'package:flutter/material.dart';
import 'package:lazy_post/domain/db/parcel_db.dart';
import 'package:lazy_post/domain/entity/parcel_history.dart';

class HistoryViewModel extends ChangeNotifier{
  var _parcels = <Map>[];
  List<Map> get parcels => _parcels;
  bool loading = true;
  HistoryViewModel(){
    _getParcels();
  }

  String getImageUrl (int logisticId){
    var image = {
      2 : 'images/novaposhta.png',
      5 : 'images/justin.png',
      6 : 'images/meest.png'
    };
    return image[logisticId] ?? 'images/dostavka_mvk.png';
  }
  // void onLogisticTap(BuildContext context, int index) {
  //   final data = _logistics[index];
  //   Navigator.of(context).pushNamed(
  //     MainNavigationRouteNames.searchingResults,
  //     arguments: data,
  //   );
  // }

  void _getParcels() async {
    _parcels = (await ParcelDB.getParcels());
    loading = false;
    _updateState();
  }

  void delFromHistory(BuildContext context,int id) async{
      await ParcelDB.deleteParcel(id);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Удалено!'),
      ));
      _updateState();
  }

  void _updateState() {
    notifyListeners();
  }

}