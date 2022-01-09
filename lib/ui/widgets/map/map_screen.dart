import 'dart:async';
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
    return MaterialApp(
        //title: 'Flutter Google Maps Demo',
        home: Scaffold(
      body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: model.startPoint,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
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
          padding: const EdgeInsets.only(right: 1 )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: FloatingActionButton(
          onPressed: () {
            model.sendDataBack(context);
          },
          child: const Icon(Icons.check),
        ),
      ),
    ));
  }
}
