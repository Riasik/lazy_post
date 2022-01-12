import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazy_post/configuration/consts.dart';
import 'package:lazy_post/domain/db/local_storage.dart';
import 'package:lazy_post/domain/entity/logistic.dart';
import 'package:lazy_post/domain/entity/point.dart';

class SearchingResultsViewModel extends ChangeNotifier {
  final _localStorage = LocalStorage();
  final startPoint = const CameraPosition(target: Const.kiev, zoom: 10);
  final Logistic _logistic;
  late LatLng senderPoint, receiverPoint;
  late List<Marker> currentList;
  bool loading = true;
  final Completer<GoogleMapController> controller = Completer();


  //ui
  int selectedTab = 0;
  

  SearchingResultsViewModel(this._logistic){
    currentList = convertToMarkers([..._logistic.from, ..._logistic.to]);
    getPoints();
  }

  void onChangePosition(int tab){
    if(tab != selectedTab){
      if(tab == 0){
        _goToPlace(senderPoint);
        selectedTab = 0;

      }else{
        _goToPlace(receiverPoint);
        selectedTab = 1;
      }
      _updateState();
    }
  }

  Future<void> _goToPlace(LatLng p) async{
    final GoogleMapController c = await controller.future;
    c.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: p,zoom: 13)));
  }



  List<Marker> convertToMarkers(List<Point> list){
    List<Marker> result = [];
    for(Point point in list){
        result.add(Marker(
            markerId:  MarkerId(point.pointNumber.toString()),
            infoWindow:  InfoWindow(title: point.pointNumber.toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            position: LatLng( point.lat, point.lng)));

    }
    return result;
  }

  void getPoints() async{
    senderPoint = LatLng(await _localStorage.get('senderLat'),
    await _localStorage.get('senderLng'));
    receiverPoint = LatLng(await _localStorage.get('receiverLat'),
    await _localStorage.get('receiverLng'));
    loading = false;
    _updateState();
  }

  void _updateState() {
    notifyListeners();
  }
}