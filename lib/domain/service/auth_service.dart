import '/domain/data_providers/session_data_provider.dart';

// import '/domain/api_client/auth_api_client.dart';

class AuthService {
  final _sessionDataProvider = SessionDataProvider();

  Future<bool> isAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final userId = await _sessionDataProvider.getUserId();
    final isAuth = sessionId != null && userId != null;
    return isAuth;
  }
  // //send phone & get ref
  // Future<void> authCode(String phone) async {
  //   final sessionId = await _authApiClient.getSession(phone);
  //   print('sessionId $sessionId');
  //   await _sessionDataProvider.setSessionId(sessionId);
  // }
  // Future<void> auth(String code) async {
  //   final sessionId = await _sessionDataProvider.getSessionId();
  //   final userId = await _authApiClient.auth(code, sessionId.toString());
  //   await _sessionDataProvider.setUserId(userId);
  // }
  // Future<void> login(String login, String password) async {
  //   final sessionId = await _authApiClient.auth(
  //     username: login,
  //     password: password,
  //   );
  //   final accountId = await _accountApiClient.getAccountInfo(sessionId);
  //   await _sessionDataProvider.setSessionId(sessionId);
  //   await _sessionDataProvider.setAccountId(accountId);
  // }
  //
  Future<void> logout() async {
    await _sessionDataProvider.deleteSessionId();
    await _sessionDataProvider.deleteUserId();
  }
}
