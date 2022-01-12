import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazy_post/ui/widgets/searching_results/searching_results_model.dart';
import 'package:provider/src/provider.dart';

class SearchingResultsScreen extends StatelessWidget {
  SearchingResultsScreen({Key? key}) : super(key: key);
  final Completer<GoogleMapController> _controller = Completer();
  
  @override
  Widget build(BuildContext context) {
    final model = context.watch<SearchingResultsViewModel>();
    return MaterialApp(
        home: Scaffold(
          body: model.loading ? const Center(
            child: CircularProgressIndicator(),
          ) :
              GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(target: model.receiverPoint, zoom: 15),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  markers: model.from.map((e) => e).toSet(),
                  padding: const EdgeInsets.only(bottom: 0, right: 0)),

        ));
  }
}
