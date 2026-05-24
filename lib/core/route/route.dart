import 'package:flutter/material.dart';
import 'package:lms/features/auth/pages/login.dart';
import 'package:lms/features/auth/pages/sign_up.dart';
import 'package:lms/features/auth/pages/verification_otp.dart';
import 'package:lms/features/course/page/create_course.dart';
import 'package:lms/features/home/home.dart';
import 'package:lms/features/trainer/pages/apply_trainer.dart';
import 'package:lms/features/trainer/pages/trainer_profile.dart';

class AppRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    dynamic args = settings.arguments;

    return MaterialPageRoute(
      builder: (context) {
        switch (settings.name) {
          case Homepage.routeName:
            return Homepage();

          case Login.routeName:
            return Login();

          case VerificationOtp.routeName:
            return VerificationOtp(email: args['email']);

          case UserLogin.routeName:
            return UserLogin();

          case TrainerProfile.routeName:
            return TrainerProfile();

          case ApplyTrainer.routeName:
            return ApplyTrainer();

          case CreateCourse.routeName:
            return CreateCourse();

          default:
            return Scaffold(body: Text("Invalid 404 route not found"));
        }
      },
    );
  }
}
