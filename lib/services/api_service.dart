import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/api_response_model.dart';

class ApiService {
  static const String baseUrl = 'https://authenticatio-with-otp.vercel.app/api'; // Change to your API URL
  static const Duration timeout = Duration(seconds: 30);

  // Signup - Request OTP
  static Future<ApiResponse<Map<String, dynamic>>> requestSignupOTP({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/signup'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'name': name,
              'email': email,
              'password': password,
            }),
          )
          .timeout(timeout);

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse(
          success: body['success'] ?? false,
          message: body['message'] ?? 'OTP sent successfully',
          data: body['data'],
        );
      } else {
        return ApiResponse(
          success: false,
          message: body['message'] ?? 'Failed to request OTP',
          error: response.statusCode.toString(),
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error',
        error: e.toString(),
      );
    }
  }

  // Signup - Verify OTP
  static Future<ApiResponse<Map<String, dynamic>>> verifySignupOTP({
    required String email,
    required String otp,
    required String name,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/verify-signup-otp'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': email,
              'otp': otp,
              'name': name,
              'password': password,
            }),
          )
          .timeout(timeout);

      final body = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return ApiResponse(
          success: body['success'] ?? false,
          message: body['message'] ?? 'Signup successful',
          data: body['data'],
        );
      } else {
        return ApiResponse(
          success: false,
          message: body['message'] ?? 'OTP verification failed',
          error: response.statusCode.toString(),
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error',
        error: e.toString(),
      );
    }
  }

  // Login - Request OTP
  static Future<ApiResponse<Map<String, dynamic>>> requestLoginOTP({
    required String email,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/request-login-otp'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email}),
          )
          .timeout(timeout);

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse(
          success: body['success'] ?? false,
          message: body['message'] ?? 'OTP sent successfully',
          data: body['data'],
        );
      } else {
        return ApiResponse(
          success: false,
          message: body['message'] ?? 'Failed to request OTP',
          error: response.statusCode.toString(),
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error',
        error: e.toString(),
      );
    }
  }

  // Login - Verify OTP
  static Future<ApiResponse<Map<String, dynamic>>> loginWithOTP({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/login-with-otp'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': email,
              'otp': otp,
            }),
          )
          .timeout(timeout);

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse(
          success: body['success'] ?? false,
          message: body['message'] ?? 'Login successful',
          data: body['data'],
        );
      } else {
        return ApiResponse(
          success: false,
          message: body['message'] ?? 'Login failed',
          error: response.statusCode.toString(),
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error',
        error: e.toString(),
      );
    }
  }

  // Get Profile - Requires JWT Token
  static Future<ApiResponse<Map<String, dynamic>>> getProfile({
    required String token,
  }) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/auth/profile'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(timeout);

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse(
          success: body['success'] ?? false,
          message: body['message'] ?? 'Profile fetched successfully',
          data: body['data'],
        );
      } else {
        return ApiResponse(
          success: false,
          message: body['message'] ?? 'Failed to fetch profile',
          error: response.statusCode.toString(),
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error',
        error: e.toString(),
      );
    }
  }
}
