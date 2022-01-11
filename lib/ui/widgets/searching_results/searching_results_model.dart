import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazy_post/configuration/consts.dart';
import 'package:lazy_post/domain/entity/logistic.dart';
import 'package:lazy_post/domain/entity/point.dart';

class SesearchingResultsViewModel extends ChangeNotifier {
  final startPoint = const CameraPosition(target: Const.kiev, zoom: 10);
  Logistic logistic;
  late List<Marker> from;
  late List<Marker> to;

  SesearchingResultsViewModel(this.logistic){
    from = convertToMarkers(logistic.from);
    to = convertToMarkers(logistic.to);
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
}