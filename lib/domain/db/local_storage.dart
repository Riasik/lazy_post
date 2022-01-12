import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<double> get(String name) async {
    final id = (await _sharedPreferences).getDouble(name) ?? 0;
    return id;
  }

  Future<void> save(String name, double d) async {
    (await _sharedPreferences).setDouble(name, d);
  }
}