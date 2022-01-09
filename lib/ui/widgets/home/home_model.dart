import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazy_post/configuration/consts.dart';
import 'package:lazy_post/domain/api_client/api_client_exception.dart';
import 'package:lazy_post/domain/entity/parcel.dart';
import 'package:lazy_post/domain/service/logistic_service.dart';
import 'package:lazy_post/ui/navigation/main_navigation.dart';

class HomeViewModel extends ChangeNotifier {
  final _logisticService = LogisticService();
  double weight = 0.1;
  double senderDistance = 0.5;
  double receiverDistance = 0.5;
  final lengthTextController = TextEditingController(text: '5');
  final widthTextController = TextEditingController(text: '4');
  final heightTextController = TextEditingController(text: '2');
  final volumeTextController = TextEditingController(text: '0.00004');
  final priceTextController = TextEditingController(text: '1');
  double? senderLat, senderLng, receiverLat, receiverLng;
  String errMessage = '';

  void calculateVolume() {
    volumeTextController.text = ((double.parse(lengthTextController.text) *
                double.parse(widthTextController.text) *
                double.parse(heightTextController.text)) /
            1000000)
        .toString();
    _updateState();
  }

  void changeWeight(double w) {
    if (w != weight) {
      weight = w;
      _updateState();
    }
  }

  void checkLogisticResult(BuildContext context) async {
    try {
      var response = await _logisticService.logistics(Parcel(
          weight: weight,
          length: double.parse(lengthTextController.text),
          price: double.parse(priceTextController.text),
          width: double.parse(widthTextController.text),
          height: double.parse(heightTextController.text),
          volume: double.parse(volumeTextController.text),
          senderLat: senderLat,
          senderLng: senderLng,
          senderDistance: senderDistance,
          receiverLat: receiverLat,
          receiverLng: receiverLng,
          receiverDistance: receiverDistance));
      if (response.data.isNotEmpty) {
        Navigator.of(context).pushNamed(
          MainNavigationRouteNames.logisticList,
          arguments: response.data,
        );
      } else {
        errMessage = 'Ошибка!';
      }
    } on ApiClientException catch (e) {
      errMessage = 'Ошибка: $e';
    }
  }

  bool checkSenderLocation() {
    return senderLat != null && senderLng != null ? true : false;
  }

  bool checkReceiverLocation() {
    return receiverLat != null && receiverLng != null ? true : false;
  }

  Future<void> setPosition(BuildContext context,{required String whom}) async {
      if(whom == Const.sender){
        LatLng location = await Navigator.of(context).pushNamed(MainNavigationRouteNames.mapScreen,
            arguments: whom) as LatLng;
        senderLat = location.latitude;
        senderLng = location.longitude;
        _updateState();
      }else if(whom == Const.receiver){
        LatLng location = await Navigator.of(context).pushNamed(MainNavigationRouteNames.mapScreen,
            arguments: whom) as LatLng;
        receiverLat = location.latitude;
        receiverLng = location.longitude;
        _updateState();
      }
  }

  void _updateState() {
    notifyListeners();
  }
}

