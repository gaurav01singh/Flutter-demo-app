import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/splash_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/login/otp_verification_screen.dart';
import '../screens/signup/signup_screen.dart';
import '../screens/signup/signup_otp_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/dashboard_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
            path: 'otp',
            builder: (context, state) {
              final email = state.extra as String? ?? '';
              return OTPVerificationScreen(email: email);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
        routes: [
          GoRoute(
            path: 'otp',
            builder: (context, state) {
              final data = state.extra as Map<String, String>? ?? {};
              return SignupOTPScreen(
                name: data['name'] ?? '',
                email: data['email'] ?? '',
                password: data['password'] ?? '',
              );
            },
          ),
        ],
      ),

      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),  // Bodmas 10-tab dashboard
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),

    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
  );
}

// ... other import