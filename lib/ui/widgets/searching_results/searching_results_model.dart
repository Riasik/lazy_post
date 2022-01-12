import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazy_post/configuration/consts.dart';
import 'package:lazy_post/domain/db/local_storage.dart';
import 'package:lazy_post/domain/db/parcel_db.dart';
import 'package:lazy_post/domain/entity/logistic.dart';
import 'package:lazy_post/domain/entity/parcel.dart';
import 'package:lazy_post/domain/entity/point.dart';

class SearchingResultsViewModel extends ChangeNotifier {
  final _localStorage = LocalStorage();
  final startPoint = const CameraPosition(target: Const.kiev, zoom: 10);
  Logistic logistic;
  late LatLng senderPoint, receiverPoint;
  late List<Marker> from;
  late List<Marker> to;
  bool loading = true;

  SearchingResultsViewModel(this.logistic){
    from = convertToMarkers(logistic.from);
    to = convertToMarkers(logistic.to);
    getPoints();
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