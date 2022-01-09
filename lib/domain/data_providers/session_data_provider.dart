import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const sessionId = 'session_id';
  static const userId = 'user_id';
}

class SessionDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> getSessionId() => _secureStorage.read(key: _Keys.sessionId);

  Future<void> setSessionId(String value) {
    return _secureStorage.write(key: _Keys.sessionId, value: value);
  }

  Future<void> deleteSessionId() {
    return _secureStorage.delete(key: _Keys.sessionId);
  }
  Future<String?> getUserId() => _secureStorage.read(key: _Keys.userId);

  Future<void> setUserId(String value) {
    return _secureStorage.write(key: _Keys.userId, value: value);
  }

  Future<void> deleteUserId() {
    return _secureStorage.delete(key: _Keys.userId);
  }
}
