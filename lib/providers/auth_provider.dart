import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  late StorageService _storageService;
  User? _user;
  String? _token;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  User? get user => _user;
  String? get token => _token;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _token != null;

  AuthProvider(SharedPreferences prefs) {
    _storageService = StorageService(prefs);
    _loadStoredData();
  }

  // Load stored data on app start
  void _loadStoredData() {
    final token = _storageService.getToken();
    final userData = _storageService.getUserData();

    if (token != null && userData != null) {
      _token = token;
      try {
        final userJson = jsonDecode(userData);
        _user = User.fromJson(userJson);
      } catch (e) {
        _token = null;
      }
    }
  }

  // Signup - Step 1: Request OTP
  Future<bool> requestSignupOTP({
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final response = await ApiService.requestSignupOTP(
        name: name,
        email: email,
        password: password,
      );

      if (response.success) {
        _setLoading(false);
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Signup - Step 2: Verify OTP
  Future<bool> verifySignupOTP({
    required String email,
    required String otp,
    required String name,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final response = await ApiService.verifySignupOTP(
        email: email,
        otp: otp,
        name: name,
        password: password,
      );

      if (response.success && response.data != null) {
        final userData = response.data!['user'];
        final token = response.data!['token'];

        _user = User.fromJson(userData);
        _token = token;

        await _storageService.saveToken(token);
        await _storageService.saveUserData(jsonEncode(userData));

        _setLoading(false);
        notifyListeners();
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Login - Step 1: Request OTP
  Future<bool> requestLoginOTP({required String email}) async {
    _setLoading(true);
    _clearError();

    try {
      final response = await ApiService.requestLoginOTP(email: email);

      if (response.success) {
        _setLoading(false);
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Login - Step 2: Verify OTP
  Future<bool> loginWithOTP({
    required String email,
    required String otp,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final response = await ApiService.loginWithOTP(
        email: email,
        otp: otp,
      );

      if (response.success && response.data != null) {
        final userData = response.data!['user'];
        final token = response.data!['token'];

        _user = User.fromJson(userData);
        _token = token;

        await _storageService.saveToken(token);
        await _storageService.saveUserData(jsonEncode(userData));

        _setLoading(false);
        notifyListeners();
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('An error occurred: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    _user = null;
    _token = null;
    await _storageService.clearAll();
    notifyListeners();
  }

  // Helper methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}
