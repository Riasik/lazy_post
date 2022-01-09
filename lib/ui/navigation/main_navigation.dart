import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazy_post/domain/entity/logistic.dart';

import '/domain/factoryes/scren_factory.dart';
import 'package:flutter/material.dart';

abstract class MainNavigationRouteNames {
  static const loaderWidget = '/';
  static const auth = '/auth';
  static const homeScreen = '/home';
  static const mapScreen = '/home/map';
  static const logisticList = '/home/logistic_list';
  static const searchingResults = '/home/logistic_list/searching_results';

  // static const mainScreen = '/main_screen';
  // static const movieDetails = '/main_screen/movie_details';
  // static const movieTrailerWidget = '/main_screen/movie_details/trailer';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.loaderWidget: (_) => _screenFactory.makeLoader(),
    MainNavigationRouteNames.homeScreen: (_) => _screenFactory.makeHomeScreen(),
    //MainNavigationRouteNames.mapScreen: (_) => _screenFactory.makeMapScreen(whom),
  };
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.logisticList:
        final arguments = settings.arguments;
        final list = arguments is List<Logistic> ? arguments : null;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeLogisticListScreen(list!),
        );
      case MainNavigationRouteNames.mapScreen:
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeMapScreen(),
        );
      case MainNavigationRouteNames.searchingResults:
        final arguments = settings.arguments;
        final logistic = arguments is Logistic ? arguments : null;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeSearchingResultsScreen(logistic!),
        );
      default:
        const widget = Text('Navigation error!!!');
        return MaterialPageRoute(builder: (_) => widget);
    }
  }

  static void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      MainNavigationRouteNames.loaderWidget,
          (route) => false,
    );
  }
}
