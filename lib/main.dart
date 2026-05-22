import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/route/route.dart';
import 'package:lms/features/auth/bloc/login/login_bloc.dart';
import 'package:lms/features/auth/bloc/otp/otp_bloc.dart';
import 'package:lms/core/bloc/profile/profile_bloc.dart';
import 'package:lms/features/auth/bloc/sign_up/sign_up_bloc.dart';
import 'package:lms/features/auth/pages/login.dart';
// import 'package:lms/features/auth/pages/login.dart';
import 'package:lms/features/trainer/bloc/apply_trainer/apply_trainer_bloc.dart';
import 'package:lms/features/trainer/bloc/bloc/trainer_profile_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpBloc()),
        BlocProvider(create: (context) => OtpBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => TrainerProfileBloc()),
        BlocProvider(create: (context) => ApplyTrainerBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        initialRoute: Login.routeName,
        onGenerateRoute: AppRoute.onGenerateRoute,

        // home: Login(),
      ),
    );
  }
}
