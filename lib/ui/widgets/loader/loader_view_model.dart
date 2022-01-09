import '/domain/service/auth_service.dart';
import '/ui/navigation/main_navigation.dart';
import '/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class LoaderViewModel {
  final BuildContext context;
  final _authService = AuthService();

  LoaderViewModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final isAuth = await _authService.isAuth();
    final nextScreen = MainNavigationRouteNames.homeScreen;
        // isAuth
        // ? MainNavigationRouteNames.homeScreen
        // : MainNavigationRouteNames.auth;
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}
