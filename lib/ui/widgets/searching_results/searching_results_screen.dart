import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazy_post/ui/theme/app_colors.dart';
import 'package:lazy_post/ui/widgets/searching_results/searching_results_model.dart';
import 'package:provider/src/provider.dart';

class SearchingResultsScreen extends StatelessWidget {
  const SearchingResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SearchingResultsViewModel>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.mainDarkBlue,
          child: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: model.selectedTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Отправитель',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Получатель',
          ),
        ],
        onTap: model.onChangePosition,
      ),
      body: model.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition:
                  CameraPosition(target: model.senderPoint, zoom: 13),
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
