import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lms/core/route/route.dart';
import 'package:lms/features/admin/bloc/add_category/add_category_bloc.dart';
import 'package:lms/features/auth/bloc/login/login_bloc.dart';
import 'package:lms/features/auth/bloc/otp/otp_bloc.dart';
import 'package:lms/core/bloc/profile/profile_bloc.dart';
import 'package:lms/features/auth/bloc/sign_up/sign_up_bloc.dart';
import 'package:lms/features/auth/pages/login.dart';
import 'package:lms/features/course/bloc/get_category/get_category_bloc.dart';
import 'package:lms/features/home/home.dart';
import 'package:lms/features/trainer/bloc/apply_trainer/apply_trainer_bloc.dart';
import 'package:lms/features/trainer/bloc/bloc/trainer_profile_bloc.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: "access_token");
  runApp(MyApp(isLoggedIn: token != null && token.isNotEmpty));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

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
        BlocProvider(create: (context) => GetCategoryBloc()),
        BlocProvider(create: (context) => AddCategoryBloc()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        initialRoute: isLoggedIn ? Homepage.routeName : Login.routeName,
        onGenerateRoute: AppRoute.onGenerateRoute,

        // home: Login(),
      ),
    );
  }
}
