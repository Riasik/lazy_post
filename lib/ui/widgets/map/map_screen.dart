import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazy_post/ui/widgets/map/map_model.dart';
import 'package:provider/src/provider.dart';

class MapScreen extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();

  MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MapViewModel>();
    return Scaffold(
          body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: model.startPoint,
          onMapCreated: (GoogleMapController controller) {
            model.controller.complete(controller);
          },
          onTap: (LatLng tab) {
            model.markers = [
              Marker(
                  markerId: const MarkerId('1'),
                  infoWindow: const InfoWindow(title: 'from'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                  position: tab)
            ];
          },
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: model.markers.map((e) => e).toSet(),
          padding: const EdgeInsets.only(right: 1)),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 90.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment:  CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'my_location',
              onPressed: () {
                model.currentPosition();
              },
              child: const Icon(Icons.my_location_outlined),
            ),
            const SizedBox(height: 10,),
            FloatingActionButton(
              heroTag: 'ok',
              onPressed: () {
                model.sendDataBack(context);
              },
              child: const Icon(Icons.check),
            ),
          ],
        ),
      ),
    );
  }
}
