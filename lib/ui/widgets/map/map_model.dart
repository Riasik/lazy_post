import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazy_post/configuration/consts.dart';

class MapViewModel extends ChangeNotifier {
  MapViewModel();
  final startPoint = const CameraPosition(target: Const.kiev, zoom: 10);
  List<Marker> _markers = [];

  set markers(List<Marker> value) {
    _markers = value;
    _updateState();
  }

  List<Marker> get markers => _markers;

  void sendDataBack(BuildContext context) {
    if(_markers.isEmpty) {
      Navigator.pop(context);
    } else {
      Navigator.pop(context, _markers.first.position);
    }
  }

  void _updateState() {
    notifyListeners();
  }

}