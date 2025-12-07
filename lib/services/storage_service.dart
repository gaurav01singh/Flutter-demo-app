import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // Token Management
  Future<void> saveToken(String token) async {
    await _prefs.setString('jwt_token', token);
  }

  String? getToken() {
    return _prefs.getString('jwt_token');
  }

  Future<void> deleteToken() async {
    await _prefs.remove('jwt_token');
  }

  // User Data
  Future<void> saveUserData(String userData) async {
    await _prefs.setString('user_data', userData);
  }

  String? getUserData() {
    return _prefs.getString('user_data');
  }

  Future<void> deleteUserData() async {
    await _prefs.remove('user_data');
  }

  // Clear all
  Future<void> clearAll() async {
    await _prefs.clear();
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return _prefs.containsKey('jwt_token');
  }
}
