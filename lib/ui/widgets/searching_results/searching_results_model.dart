import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazy_post/configuration/consts.dart';
import 'package:lazy_post/domain/db/local_storage.dart';
import 'package:lazy_post/domain/entity/logistic.dart';
import 'package:lazy_post/domain/entity/point.dart';

import 'marker.dart';

class SearchingResultsViewModel extends ChangeNotifier {
  final _localStorage = LocalStorage();
  final _otherMarkers = MarkerGenerator(100);
  final Completer<GoogleMapController> controller = Completer();

  //final startPoint = const CameraPosition(target: Const.kiev, zoom: 20);
  final Logistic _logistic;
  late LatLng senderPoint, receiverPoint;
  late List<Marker> currentList;
  late BitmapDescriptor _newPost,_newPostT, _justIn,_justInT, _meest, _meestT, _other, _otherT;

  //for ui
  int selectedTab = 0;
  bool loading = true;

  SearchingResultsViewModel(this._logistic){
    loadData();
  }

  void loadData() async{
    _newPost = await _otherMarkers.createBitmapDescriptorFromIconData(Icons.store, Colors.white, Colors.red, Colors.red);
    _newPostT = await _otherMarkers.createBitmapDescriptorFromIconData(Icons.corporate_fare, Colors.white, Colors.red, Colors.red);
    _justIn = await _otherMarkers.createBitmapDescriptorFromIconData(Icons.store, Colors.white, Colors.blue, Colors.blue);
    _justInT = await _otherMarkers.createBitmapDescriptorFromIconData(Icons.corporate_fare, Colors.white, Colors.blue, Colors.blue);
    _meest = await _otherMarkers.createBitmapDescriptorFromIconData(Icons.store, Colors.white, Colors.blueAccent, Colors.blueAccent);
    _meestT = await _otherMarkers.createBitmapDescriptorFromIconData(Icons.corporate_fare, Colors.white, Colors.blueAccent, Colors.blueAccent);
    _other = await _otherMarkers.createBitmapDescriptorFromIconData(Icons.store, Colors.white, Colors.grey, Colors.grey);
    _otherT = await _otherMarkers.createBitmapDescriptorFromIconData(Icons.corporate_fare, Colors.white, Colors.grey, Colors.grey);
    currentList = convertToMarkers([..._logistic.from, ..._logistic.to],_logistic.logisticId);
    senderPoint = LatLng(await _localStorage.get('senderLat'),
        await _localStorage.get('senderLng'));
    receiverPoint = LatLng(await _localStorage.get('receiverLat'),
        await _localStorage.get('receiverLng'));
    currentList.add(Marker(
        markerId:   const MarkerId('from'),
        infoWindow:  const InfoWindow(title: 'Отправитель'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: senderPoint));
    currentList.add(Marker(
        markerId:   const MarkerId('to'),
        infoWindow:  const InfoWindow(title: 'Получатель'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: receiverPoint));
    loading = false;
    _updateState();
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

  List<Marker> convertToMarkers(List<Point> list, int? logisticId){
    List<Marker> result = [];
    for(Point point in list){
        result.add(Marker(
            markerId:  MarkerId(point.pointNumber.toString()),
            infoWindow:  InfoWindow(title: '${_logistic.nameUa} №${point.pointNumber}', snippet: point.pointType),
            icon: checkIcon(logisticId, point.postTerminal),
            position: LatLng( point.lat, point.lng)));
    }
    return result;
  }

  BitmapDescriptor checkIcon(int? logisticId, bool postTerminal){
    switch(logisticId){
      case 2: return postTerminal ? _newPostT :_newPost;
      case 5: return postTerminal ? _justInT : _justIn;
      case 6: return postTerminal ? _meestT : _meest;
      default: return postTerminal ? _otherT : _other;
    }
  }

  void _updateState() {
    notifyListeners();
  }
}