import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lazy_post/domain/entity/logistic.dart';
import 'package:lazy_post/domain/entity/parcel.dart';
import 'package:lazy_post/domain/entity/parcel_for_near.dart';
import '/domain/factoryes/scren_factory.dart';
import 'package:flutter/material.dart';

abstract class MainNavigationRouteNames {
  static const loaderWidget = '/';
  static const auth = '/auth';
  static const homeScreen = '/home';
  static const nearPoints = '/home/near_points';
  static const homeHistory = '/home/history';
  static const mapScreen = '/home/map';
  static const logisticList = '/home/logistic_list';
  static const searchingResults = '/home/logistic_list/searching_results';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.loaderWidget: (_) => _screenFactory.makeLoader(),
    MainNavigationRouteNames.homeScreen: (_) => _screenFactory.makeHomeScreen(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.logisticList:
        final arguments = settings.arguments;
        final parcel = arguments is Parcel ? arguments : null;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeLogisticListScreen(parcel!),
        );
      case MainNavigationRouteNames.mapScreen:
        final arguments = settings.arguments;
        final location = arguments is LatLng ? arguments : null;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeMapScreen(location),
        );
      case MainNavigationRouteNames.nearPoints:
        final arguments = settings.arguments;
        final parcel = arguments is ParcelNear ? arguments : null;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeNearPointsScreen(parcel!),
        );
      case MainNavigationRouteNames.homeHistory:
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeHistoryScreen(),
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
