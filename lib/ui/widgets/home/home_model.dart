import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazy_post/configuration/consts.dart';
import 'package:lazy_post/domain/db/local_storage.dart';
import 'package:lazy_post/domain/db/parcel_db.dart';
import 'package:lazy_post/domain/entity/parcel.dart';
import 'package:lazy_post/ui/navigation/main_navigation.dart';

enum Size{xs,s,m,l,xl}

class B{
  String name;
  String url;
  Size size;
  bool active;
  B(this.size, this.active,this.name,this.url);

}
class HomeViewModel extends ChangeNotifier {
  final _localStorage = LocalStorage();
  double weight = 0.1, senderDistance = 0.5, receiverDistance = 0.5;
  final lengthTextController = TextEditingController(text: '5');
  final widthTextController = TextEditingController(text: '4');
  final heightTextController = TextEditingController(text: '2');
  final volumeTextController = TextEditingController(text: '0.00004');
  final priceTextController = TextEditingController(text: '1');
  LatLng? senderLocation, receiverLocation;
  bool senderOffice = true, senderTerminal = true, receiverOffice = true, receiverTerminal = true;

  final List<B> buttons = [
    B(Size.xs,true,'XS','images/parcel/XS.jpg'),
    B(Size.s,false,'S','images/parcel/S.jpg'),
    B(Size.m,false,'M','images/parcel/M.jpg'),
    B(Size.l,false,'L','images/parcel/L.jpg'),
    B(Size.xl,false,'XL','images/parcel/XL.jpg')];

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
    if(checkAllParams()){
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

  Future<void> setPosition(BuildContext context, {required String whom}) async {
    if (whom == Const.sender) {
      LatLng? location = await Navigator.of(context).pushNamed(
          MainNavigationRouteNames.mapScreen,
          arguments: senderLocation ?? null) as LatLng?;
      if(location != null){
        senderLocation = location;
        _updateState();
      }
    } else if (whom == Const.receiver) {
      LatLng? location = await Navigator.of(context).pushNamed(
          MainNavigationRouteNames.mapScreen,
          arguments: receiverLocation ?? null) as LatLng?;
      if(location != null){
        receiverLocation = location;
        _updateState();
      }
    }
  }

  void saveToHistory(Parcel p){
     ParcelDB.createParcel(p);
    _localStorage.save('senderLat',p.senderLat!);
    _localStorage.save('senderLng',p.senderLng!);
    _localStorage.save('receiverLat',p.receiverLat!);
    _localStorage.save('receiverLng',p.receiverLng!);
  }

  void changeTerminalOffice(String name){
    bool change(bool t){
      if(t) return false;
      else if(!t) return true;
      else return false;
    }
    switch (name){
      case Const.senderOffice: senderOffice = change(senderOffice); break;
      case Const.senderTerminal: senderTerminal = change(senderTerminal); break;
      case Const.receiverOffice: receiverOffice = change(receiverOffice); break;
      case Const.receiverTerminal: receiverTerminal = change(receiverTerminal); break;
    }
    _updateState();
  }

  bool checkAllParams(){
    if(!check(weight)) return false;
    if(!check(senderDistance)) return false;
    if(!check(receiverDistance)) return false;
    if(!check(receiverDistance)) return false;
    if(!check(receiverDistance)) return false;
    if(!check(lengthTextController)) return false;
    if(!check(widthTextController)) return false;
    if(!check(heightTextController)) return false;
    if(!check(volumeTextController)) return false;
    if(!check(priceTextController)) return false;
    if(!check(senderLocation)) return false;
    if(!check(receiverLocation)) return false;
    return true;
  }

  void setInit(){
    weight = 0.1; senderDistance = 0.5; receiverDistance = 0.5;
    lengthTextController.text =  '5';
    widthTextController.text = '4';
    heightTextController.text = '2';
    volumeTextController.text = '0.00004';
    priceTextController.text = '1';
    senderLocation = null; receiverLocation = null;
    senderOffice = true; senderTerminal = true; receiverOffice = true; receiverTerminal = true;
    _updateState();
  }

  bool check<T>(T a) => a != null && a != '' && a != 0 ? true : false;

  void _updateState() {
    notifyListeners();
  }
}

