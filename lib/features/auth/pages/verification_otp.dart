import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/extension/context_extesion.dart';
import 'package:lms/features/auth/bloc/otp/otp_bloc.dart';
import 'package:lms/features/auth/model/verify_otp_request_model.dart';
import 'package:lms/features/home/home.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationOtp extends StatelessWidget {
  const VerificationOtp({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Verify your email",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Enter your otp sent on $email",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 24, 2, 89),
              ),
            ),
            BlocListener<OtpBloc, OtpState>(
              listener: (context, state) {
                if (state is OtpLoading) {
                  context.showLoadingDialog();
                } else if (state is OtpLoaded) {
                  context.pop();
                  context.showSnackbar("otp verified successfully");
                  context.pushReplacement(Homepage());
                } else if (state is OtpFailure) {
                  context.pop();
                  context.showSnackbar(state.msg);
                }
              },
              child: MaterialPinField(
                length: 6,
                onCompleted: (pin) => context.read<OtpBloc>().add(
                  OtpEvent(
                    otpRequestModel: VerifyOtpRequestModel(
                      email: email,
                      otp: pin,
                    ),
                  ),
                ),
                theme: MaterialPinTheme(
                  shape: MaterialPinShape.outlined,
                  cellSize: Size(40, 40),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
