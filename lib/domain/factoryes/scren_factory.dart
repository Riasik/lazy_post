import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:lazy_post/domain/entity/logistic.dart';
import 'package:lazy_post/domain/entity/parcel.dart';
import 'package:lazy_post/domain/entity/parcel_for_near.dart';
import 'package:lazy_post/ui/widgets/history/history_model.dart';
import 'package:lazy_post/ui/widgets/history/history_screen.dart';
import 'package:lazy_post/ui/widgets/home/home_model.dart';
import 'package:lazy_post/ui/widgets/map/map_model.dart';
import 'package:lazy_post/ui/widgets/map/map_screen.dart';
import 'package:lazy_post/ui/widgets/logistic_list/logistic_list_model.dart';
import 'package:lazy_post/ui/widgets/logistic_list/logistic_list_screen.dart';
import 'package:lazy_post/ui/widgets/near_points_map/near_points_model.dart';
import 'package:lazy_post/ui/widgets/near_points_map/near_points_screen.dart';
import 'package:lazy_post/ui/widgets/searching_results/searching_results_screen.dart';
import 'package:lazy_post/ui/widgets/searching_results/searching_results_model.dart';
import '/ui/widgets/home/home_screen.dart';

import '/ui/widgets/loader/loader_view_model.dart';
import '/ui/widgets/loader/loader_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenFactory {
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderViewModel(context),
      child: const LoaderWidget(),
      lazy: false,
    );
  }

  Widget makeHomeScreen() {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: const HomeScreenWidget(),
    );
  }
  Widget makeHistoryScreen() {
    return ChangeNotifierProvider(
      create: (_) => HistoryViewModel(),
      child: const HistoryScreen(),
    );
  }

  Widget makeLogisticListScreen(Parcel p) {
    return ChangeNotifierProvider(
      create: (_) => LogisticListViewModel(p),
      child: const LogisticListScreen(),
    );
  }

  Widget makeMapScreen(LatLng? location) {
    return ChangeNotifierProvider(
        create: (_) => MapViewModel(location),
        child: MapScreen() ,
    );
  }
  Widget makeNearPointsScreen(ParcelNear parcel) {
    return ChangeNotifierProvider(
        create: (_) => NearPointsViewModel(parcel:parcel),
        child: NearPointsScreen() ,
    );
  }
  Widget makeSearchingResultsScreen(Logistic logistic) {
    return ChangeNotifierProvider(
      create: (_) => SearchingResultsViewModel(logistic),
      child: SearchingResultsScreen() ,
    );
  }

}
