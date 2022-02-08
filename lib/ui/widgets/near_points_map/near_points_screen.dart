
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazy_post/ui/theme/app_colors.dart';
import 'package:provider/src/provider.dart';

import 'near_points_model.dart';

class NearPointsScreen extends StatelessWidget {
  const NearPointsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final model = context.watch<NearPointsViewModel>();
      return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.mainDarkBlue,
            child: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        body: model.loading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition:
            CameraPosition(target: LatLng(model.myPoint.longitude,model.myPoint.latitude), zoom: 14),
            onMapCreated: (GoogleMapController controller) {
              model.controller.complete(controller);
            },
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            markers: model.currentList.map((e) => e).toSet(),
            padding: const EdgeInsets.only(bottom: 0, right: 0)),
      );
    }
  }

