import 'dart:async';
import 'package:crafty_bay/presentation/screens/complete_profile_screen.dart';
import 'package:crafty_bay/presentation/screens/main_bottom_nav_bar_screen.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:crafty_bay/presentation/state_holders/verify_otp_controller.dart';

import '../state_holders/read_profile_controller.dart';
import '../state_holders/verify_email_controller.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/snack_message.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final OtpController _otpController = Get.put(OtpController());
  final ReadProfileController _readProfileController = Get.put(ReadProfileController());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 100),
                const AppLogo(),
                const SizedBox(height: 16),
                Text('Enter OTP Code', style: textTheme.headlineLarge),
                const SizedBox(height: 4),
                Text('A 4 digit OTP code has been sent',
                    style: textTheme.headlineSmall),
                const SizedBox(height: 24),
                _buildPinField(),
                const SizedBox(height: 16),
                GetBuilder<VerifyOtpController>(builder: (verifyOtpController) {
                  if (verifyOtpController.inProgress) {
                    return const CenteredCircularProgressIndicator();
                  }

                  return ElevatedButton(
                    onPressed: () async {
                      final result = await verifyOtpController.verifyOtp(
                          widget.email, _otpTEController.text);
                      if (result) {
                        final profileResult = await _readProfileController.readProfile();
                        if (profileResult) {
                          if (_readProfileController.profileModel?.readData == null) {
                            if (mounted) {
                              Get.to(() => CompleteProfileScreen());
                              showSnackMessage(context, "Please Complete your Profile First.");
                            }
                          } else {
                            if (mounted) {
                              Get.offAll(() => MainBottomNavBarScreen());
                              showSnackMessage(context, "Logged in Successfully!");
                            }
                          }
                        } else {
                          if (mounted) {
                            showSnackMessage(context, _readProfileController.errorMessage);
                          }
                        }
                      } else {
                        if (mounted) {
                          showSnackMessage(
                              context, verifyOtpController.errorMessage);
                        }
                      }
                    },
                    child: const Text('Next'),
                  );
                }),
                const SizedBox(height: 24),
                _buildResendCodeMessage(),
                Obx(() => TextButton(
                  onPressed: _otpController.isButtonEnabled.value ? () {
                    _otpController.resendOtp(widget.email);
                  } : null,
                  child: const Text('Resend Code'),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResendCodeMessage() {
    return Obx(() {
      return RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
          children: [
            const TextSpan(text: 'This code will expire in '),
            TextSpan(
              text: '${_otpController.countdown}s',
              style: const TextStyle(color: AppColors.primaryColor),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPinField() {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.transparent,
        selectedFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      controller: _otpTEController,
      appContext: context,
    );
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    _readProfileController.dispose();
    _otpController.dispose();
    super.dispose();
  }
}
class OtpController extends GetxController {
  var countdown = 100.obs;
  var isButtonEnabled = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void startTimer() {
    isButtonEnabled.value = false;
    countdown.value = 100;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
        isButtonEnabled.value = true;
      }
    });
  }

  void resendOtp(String email) async {
    final verifyEmailController = Get.find<VerifyEmailController>();
    final result = await verifyEmailController.verifyEmail(email);
    if (result) {
      startTimer();
      Get.snackbar('OTP Resent', 'A new OTP has been sent to your email');
    } else {
      Get.snackbar('Error', verifyEmailController.errorMessage);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

