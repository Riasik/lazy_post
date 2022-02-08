import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazy_post/configuration/consts.dart';
import 'package:lazy_post/domain/db/local_storage.dart';
import 'package:lazy_post/domain/db/parcel_db.dart';
import 'package:lazy_post/domain/entity/parcel.dart';
import 'package:lazy_post/domain/entity/parcel_for_near.dart';
import 'package:lazy_post/ui/navigation/main_navigation.dart';

enum Sizes { xs, s, m, l, xl }
enum Coordinates { sender, receiver }

class ParcelInfo{
  final double length;
  final double width;
  final double height;
  final double volume;
  final double weight;
  ParcelInfo({required this.length, required this.width,
    required this.height, required this.volume, required this.weight});
}


class B {
  String name;
  String url;
  Sizes size;
  bool active;
  B(this.size, this.active, this.name, this.url);
}

class HomeViewModel extends ChangeNotifier {
  final _localStorage = LocalStorage();
  late double weight=0.5, senderDistance=0.01, receiverDistance=0.01;
  final lengthTextController = TextEditingController(text: '12');
  final widthTextController = TextEditingController(text: '17');
  final heightTextController = TextEditingController(text: '9');
  final volumeTextController = TextEditingController(text:'0.5');
  final priceTextController = TextEditingController(text: '1');
  LatLng? senderLocation, receiverLocation;
  late bool senderOffice=true,senderTerminal=true,receiverOffice=true, receiverTerminal=true;
  bool viewEdits = false;
  bool viewEditLocation = false;

  int _parcelImgIndex = 0;
  int get parcelImgIndex => _parcelImgIndex;
  final List<ParcelInfo> catalog= [
    ParcelInfo(weight:0.5, length: 17, width: 12, height: 9,volume: 0.5),
    ParcelInfo(weight:0.5, length: 24, width: 17, height: 4,volume: 0.5),
    ParcelInfo(weight:3.8, length: 53.5, width: 38, height: 7.5,volume: 3.8),
    ParcelInfo(weight:1, length: 24, width: 17, height: 9,volume: 1),
    ParcelInfo(weight:1, length: 34, width: 24, height: 4,volume: 1),
    ParcelInfo(weight:2, length: 34, width: 24, height: 9,volume: 2),
    ParcelInfo(weight:3, length: 24, width: 24, height: 20,volume: 3),
    ParcelInfo(weight:5, length: 40, width: 24, height: 20,volume: 5),
    ParcelInfo(weight:10, length: 40, width: 35, height: 28.5,volume: 10),
    ParcelInfo(weight:20, length: 47, width: 40, height: 42,volume: 20),
    ParcelInfo(weight:30, length: 70, width: 40, height: 42,volume: 30),
  ];

  final List<B> buttons = [
    B(Sizes.xs, true, 'XS', 'images/parcel/XS.jpg'),
    B(Sizes.s, false, 'S', 'images/parcel/S.jpg'),
    B(Sizes.m, false, 'M', 'images/parcel/M.jpeg'),
    B(Sizes.l, false, 'L', 'images/parcel/L.jpeg'),
    B(Sizes.xl, false, 'XL', 'images/parcel/XL.jpg')];

  void calculateVolume() {
    volumeTextController.text = ((double.parse(lengthTextController.text) *
        double.parse(widthTextController.text) *
        double.parse(heightTextController.text)) /
        4000)
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
    if (checkAllParams()) {
      Parcel p = Parcel(
          weight: weight,
          length: double.parse(lengthTextController.text),
          price: double.parse(priceTextController.text),
          width: double.parse(widthTextController.text),
          height: double.parse(heightTextController.text),
          volume: double.parse(volumeTextController.text),
          senderLat: senderLocation?.latitude,
          senderLng: senderLocation?.longitude,
          senderDistance: senderDistance,
          receiverLat: receiverLocation?.latitude,
          receiverLng: receiverLocation?.longitude,
          receiverDistance: receiverDistance,
          senderOffice: senderOffice,
          senderTerminal: senderTerminal,
          receiverOffice: receiverOffice,
          receiverTerminal: receiverTerminal
      );
      saveToHistory(p);
      Navigator.of(context).pushNamed(
          MainNavigationRouteNames.logisticList,
          arguments: p);
    }
  }

  Future<void> setPosition(BuildContext context,
      {required Coordinates whom}) async {
    if (whom == Coordinates.sender) {
      LatLng? location = await Navigator.of(context).pushNamed(
          MainNavigationRouteNames.mapScreen,
          arguments: senderLocation ?? null) as LatLng?;
      if (location != null) {
        senderLocation = location;
        _updateState();
      }
    } else if (whom == Coordinates.receiver) {
      LatLng? location = await Navigator.of(context).pushNamed(
          MainNavigationRouteNames.mapScreen,
          arguments: receiverLocation ?? null) as LatLng?;
      if (location != null) {
        receiverLocation = location;
        _updateState();
      }
    }
  }

  void saveToHistory(Parcel p) {
    ParcelDB.createParcel(p);
    _localStorage.save('senderLat', p.senderLat!);
    _localStorage.save('senderLng', p.senderLng!);
    _localStorage.save('receiverLat', p.receiverLat!);
    _localStorage.save('receiverLng', p.receiverLng!);
  }

  void changeTerminalOffice(String name) {
    bool change(bool t) {
      if (t)
        return false;
      else if (!t)
        return true;
      else
        return false;
    }
    switch (name) {
      case Const.senderOffice:
        senderOffice = change(senderOffice);
        break;
      case Const.senderTerminal:
        senderTerminal = change(senderTerminal);
        break;
      case Const.receiverOffice:
        receiverOffice = change(receiverOffice);
        break;
      case Const.receiverTerminal:
        receiverTerminal = change(receiverTerminal);
        break;
    }
    _updateState();
  }

  bool checkAllParams() {
    if (!check(weight)) return false;
    if (!check(senderDistance)) return false;
    if (!check(receiverDistance)) return false;
    if (!check(receiverDistance)) return false;
    if (!check(receiverDistance)) return false;
    if (!check(lengthTextController)) return false;
    if (!check(widthTextController)) return false;
    if (!check(heightTextController)) return false;
    if (!check(volumeTextController)) return false;
    if (!check(priceTextController)) return false;
    if (!check(senderLocation)) return false;
    if (!check(receiverLocation)) return false;
    return true;
  }

  void viewNearPoints(Coordinates c, BuildContext context) {
    late ParcelNear p;
    if (c == Coordinates.sender) {
      p = ParcelNear(weight: weight,
          length: double.parse(lengthTextController.text),
          price: double.parse(priceTextController.text),
          width: double.parse(widthTextController.text),
          height: double.parse(heightTextController.text),
          volume: double.parse(volumeTextController.text),
          lat: senderLocation?.latitude,
          lng: senderLocation?.longitude,
          distance: senderDistance,
          logistic: [2,5,6],
          office: true,
          terminal: true);
    } else if (c == Coordinates.receiver) {
      p = ParcelNear(weight: weight,
          length: double.parse(lengthTextController.text),
          price: double.parse(priceTextController.text),
          width: double.parse(widthTextController.text),
          height: double.parse(heightTextController.text),
          volume: double.parse(volumeTextController.text),
          lat: receiverLocation?.latitude,
          lng: receiverLocation?.longitude,
          distance: receiverDistance,
          logistic: [2,5,6],
          office: true,
          terminal: true);
    }
    Navigator.of(context).pushNamed(
        MainNavigationRouteNames.nearPoints,
        arguments: p);
  }

  void setInit() {
    weight = 0.5;
    senderDistance = 0.01;
    receiverDistance = 0.01;
    lengthTextController.text = '12';
    widthTextController.text = '17';
    heightTextController.text = '9';
    volumeTextController.text = '0.5';
    priceTextController.text = '1';
    senderLocation = null;
    receiverLocation = null;
    senderOffice = true;
    senderTerminal = true;
    receiverOffice = true;
    receiverTerminal = true;
    _updateState();
  }

  void changeSizes(int i){
    if(catalog[i] != null){
      _parcelImgIndex = i;
      weight = catalog[i].weight;
      lengthTextController.text = catalog[i].length.toString();
      widthTextController.text = catalog[i].width.toString();
      heightTextController.text = catalog[i].height.toString();
      volumeTextController.text = catalog[i].volume.toString();
    }
  }

  bool check<T>(T a) => a != null && a != '' && a != 0 ? true : false;

  void checkAndUpdateButtons(String name) {
    for (var i in buttons) {
      if (name == i.name && !i.active) {
        for (var a in buttons)
          a.active = false;
        i.active = true;
        _updateState();
      }
    }
  }

  void viewEditWindow(){
    viewEdits = viewEdits ? false : true;
    _updateState();
  }
  void viewEditLocationW(){
    viewEditLocation = viewEditLocation ? false : true;
    _updateState();
  }

  void _updateState() {
    notifyListeners();
  }
}

