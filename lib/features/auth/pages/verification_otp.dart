import 'package:flutter/material.dart';

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
            SizedBox(height: 10),
            Text(
              "Enter your otp sent on $email",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 24, 2, 89),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
