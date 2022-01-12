import 'package:lazy_post/domain/entity/logistic.dart';
import 'package:lazy_post/ui/widgets/home/home_model.dart';
import 'package:lazy_post/ui/widgets/map/map_model.dart';
import 'package:lazy_post/ui/widgets/map/map_screen.dart';
import 'package:lazy_post/ui/widgets/logistic_list/logistic_list_model.dart';
import 'package:lazy_post/ui/widgets/logistic_list/logistic_list_screen.dart';
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

  Widget makeLogisticListScreen(List<Logistic> list) {
    return ChangeNotifierProvider(
      create: (_) => LogisticListViewModel(list),
      child: const LogisticListScreen(),
    );
  }

  Widget makeMapScreen() {
    return ChangeNotifierProvider(
        create: (_) => MapViewModel(),
        child: MapScreen() ,
    );
  }
  Widget makeSearchingResultsScreen(Logistic logistic) {
    return ChangeNotifierProvider(
      create: (_) => SearchingResultsViewModel(logistic),
      child: SearchingResultsScreen() ,
    );
  }

}
