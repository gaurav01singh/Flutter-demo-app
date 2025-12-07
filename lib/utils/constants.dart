import 'package:flutter/material.dart';

class AppConstants {
  // Colors
  static const Color primaryColor = Color(0xFF2563EB);
  static const Color primaryDarkColor = Color(0xFF1E40AF);
  static const Color secondaryColor = Color(0xFF10B981);
  static const Color accentColor = Color(0xFFF97316);
  static const Color errorColor = Color(0xFFC01547);
  static const Color successColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFA84B0A);
  
  static const Color bgColor = Color(0xFFFAFAFA);
  static const Color textColor = Color(0xFF1F2121);
  static const Color textLightColor = Color(0xFF6F7C7C);
  static const Color borderColor = Color(0xFFE5E5E5);

  // Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Border Radius
  static const double radiusSmall = 6.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;

  // OTP
  static const int otpLength = 6;
  static const int otpExpiryMinutes = 10;

  // API
  static const String apiBaseUrl = 'http://192.168.1.5:5000/api';
  static const int requestTimeout = 30;
}

class BodmasColors {
  static const Color primaryColor = Color(0xFF1E3A8A);      // Deep Blue
  static const Color secondaryColor = Color(0xFF3B82F6);    // Blue
  static const Color accentColor = Color(0xFF10B981);       // Green
  static const Color successColor = Color(0xFF059669);
  static const Color warningColor = Color(0xFFEAB308);
  static const Color errorColor = Color(0xFFDC2626);
  static const Color surfaceColor = Color(0xFFF8FAFC);
  static const Color bgColor = Color(0xFFFAFAFA);
}

class BodmasConstants {
  static const double paddingSmall = 12.0;
  static const double paddingMedium = 20.0;
  static const double paddingLarge = 28.0;
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 20.0;
  
  // API
  static const String apiBaseUrl = 'http://YOUR_IP:5000/api';
}
