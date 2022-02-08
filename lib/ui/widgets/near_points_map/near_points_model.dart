import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazy_post/domain/api_client/api_client_exception.dart';
import 'package:lazy_post/domain/entity/map_point.dart';
import 'package:lazy_post/domain/entity/parcel_for_near.dart';
import 'package:lazy_post/domain/service/logistic_service.dart';
import 'package:lazy_post/ui/widgets/searching_results/marker.dart';


class NearPointsViewModel extends ChangeNotifier {
  late final List<MapPoint> _points;
  final ParcelNear parcel;
  final _logisticService = LogisticService();
  final _otherMarkers = MarkerGenerator(100);
  final Completer<GoogleMapController> controller = Completer();
  late LatLng myPoint;
  late List<Marker> currentList;
  late BitmapDescriptor _newPost,_newPostT, _justIn,_justInT, _meest, _meestT, _other, _otherT;
  bool loading = true;
  String errMessage = '';

  NearPointsViewModel({required this.parcel}){
    getData();
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
    currentList = convertToMarkers([..._points]);
    myPoint = LatLng(parcel.lng!, parcel.lat!);
    currentList.add(
        Marker(
            markerId:  MarkerId('my_point'),
            infoWindow:  InfoWindow(title: 'Выбранная точка'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            position: LatLng(parcel.lat!,parcel.lng!))
    );
    loading = false;
    _updateState();
  }

  List<Marker> convertToMarkers(List<MapPoint> list){
    List<Marker> result = [];

    for(MapPoint point in list){
      result.add(Marker(
          markerId:  MarkerId(point.pointNumber.toString()),
          infoWindow:  InfoWindow(title: '${point.logistic_name} №${point.pointNumber}', snippet: point.pointType),
          icon: checkIcon(point.logisticId, point.postTerminal),
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

  void getData() async{
    try {
      var response = await _logisticService.nearPoints(parcel);
      if (response.data.isNotEmpty) {
        _points = await response.data;
        loadData();
      } else {
        errMessage = 'Не найдено!\nПопробуйте увеличить расстояние.';
      }
    } on ApiClientException catch (e) {
      errMessage = 'Ошибка: ${e.toString()}';

    }
  }

  void _updateState() {
    notifyListeners();
  }
}