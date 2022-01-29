import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazy_post/configuration/consts.dart';

class MapViewModel extends ChangeNotifier {
  late LatLng? location;
  List<Marker> _markers = [];
  late Position position;
  late LocationPermission permission;
  late bool serviceEnabled = false;
  final Completer<GoogleMapController> controller = Completer();


  late var startPoint = const CameraPosition(target: Const.kiev, zoom: 12);
  MapViewModel(LatLng? location){
    if(location != null){
      serviceEnabled = true;
      startPoint =  CameraPosition(target: location, zoom: 12);
      _markers = [Marker(
          markerId: const MarkerId('1'),
          infoWindow: const InfoWindow(title: 'Точка'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed),
          position: location)];
    } else {
             _markers = [];
    }
  }

  set markers(List<Marker> value) {
    _markers = value;
    _updateState();
  }

  List<Marker> get markers => _markers;

  void sendDataBack(BuildContext context) {
    if(_markers.isEmpty) {
      Navigator.pop(context);
    } else {
      location = _markers.first.position;
      Navigator.pop(context, _markers.first.position);
    }
  }
  void currentPosition() async{
    var p = await _determinePosition();
    if(p is Position) {
      var currentPosition = LatLng(p.latitude, p.longitude);
      _markers = [Marker(
          markerId: const MarkerId('1'),
          infoWindow: const  InfoWindow(title: 'Точка'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed),
          position: currentPosition)
      ];
      _goToPlace(currentPosition);
    }
  }

  Future<void> _goToPlace(LatLng p) async{
    final GoogleMapController c = await controller.future;
    c.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: p,zoom: 13)));
  }

  Future<Position> _determinePosition() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  void _updateState() {
    notifyListeners();
  }
}