import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../utils/constants.dart';
import '../../utils/validators.dart';
import '../widgets/otp_input_field.dart';
import '../widgets/loading_button.dart';

class SignupOTPScreen extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const SignupOTPScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  State<SignupOTPScreen> createState() => _SignupOTPScreenState();
}

class _SignupOTPScreenState extends State<SignupOTPScreen> {
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> _focusNodes;
  int _remainingTime = 300; // 5 minutes
  late Stopwatch _stopwatch;

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());
    _startTimer();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _stopwatch.stop();
    super.dispose();
  }

  void _startTimer() {
    _stopwatch = Stopwatch()..start();
    // Timer logic would go here - update UI every second
  }

  void _verifyOTP() {
    final otp = _otpControllers.map((c) => c.text).join();

    if (Validators.validateOTP(otp) == null) {
      context.read<AuthProvider>().verifySignupOTP(
        email: widget.email,
        otp: otp,
        name: widget.name,
        password: widget.password,
      ).then((success) {
        if (success) {
          // ignore: use_build_context_synchronously
          context.go('/dashboard');
        }
      });
    }
  }

  void _resendOTP() {
    context.read<AuthProvider>().requestSignupOTP(
      name: widget.name,
      email: widget.email,
      password: widget.password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppConstants.textColor),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Verify Your Email',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'We sent a 6-digit code to ${widget.email}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppConstants.textLightColor,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => OTPInputField(
                    controller: _otpControllers[index],
                    focusNode: _focusNodes[index],
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        _focusNodes[index + 1].requestFocus();
                      } else if (value.isEmpty && index > 0) {
                        _focusNodes[index - 1].requestFocus();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Consumer<AuthProvider>(
                builder: (context, authProvider, _) {
                  if (authProvider.errorMessage != null) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppConstants.errorColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                        ),
                        child: Text(
                          authProvider.errorMessage!,
                          style: const TextStyle(
                            color: AppConstants.errorColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              LoadingButton(
                isLoading: context.watch<AuthProvider>().isLoading,
                onPressed: _verifyOTP,
                label: 'Verify & Create Account',
              ),
              const SizedBox(height: 24),
              Center(
                child: GestureDetector(
                  onTap: _resendOTP,
                  child: const Text(
                    "Didn't receive a code? Resend",
                    style: TextStyle(
                      color: AppConstants.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
