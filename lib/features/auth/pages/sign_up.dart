import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/extension/context_extesion.dart';
import 'package:lms/core/widgets/custom_text_form.dart';
import 'package:lms/core/widgets/primary_button.dart';
import 'package:lms/features/auth/bloc/sign_up/sign_up_bloc.dart';
import 'package:lms/features/auth/model/sign_up_model.dart';
import 'package:lms/features/auth/pages/verification_otp.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});
    static const String routeName = "/signup";


  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _isObscure = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: ListView(
          children: [
            Text(
              "Welcome",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 44),
            ),
            Text(
              "sign up to continue",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),

            SizedBox(height: 50),
            Form(
              key: _formkey,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [
                  Text(
                    "Name",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),

                  CustomTextForm(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length <= 3) {
                        return "name should be greater than 3 letter";
                      }
                      return null;
                    },
                    controller: _name,
                    obscureText: false,
                    prefixIcon: Icon(Icons.person),
                  ),
                  SizedBox(height: 50),
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),

                  CustomTextForm(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email cannot be empty";
                      }
                      final emailRegex = RegExp(
                        r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
                      );
                      if (!emailRegex.hasMatch(value)) {
                        return "enter valid email";
                      }
                      return null;
                    },
                    controller: _email,
                    obscureText: false,
                    prefixIcon: Icon(Icons.email),
                  ),
                  SizedBox(height: 50),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  CustomTextForm(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length <= 6) {
                        return "name should be greater than 5 letter";
                      }
                      return null;
                    },
                    controller: _password,
                    obscureText: _isObscure,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: BlocListener<SignUpBloc, SignUpState>(
                      listener: (context, state) {
                        if (state is SignUpLoading) {
                          context.showLoadingDialog();
                        } else if (state is SignUpLoaded) {
                          context.showSnackbar(state.msg);
                          context.pop();
                          Navigator.of(context).pushNamed(VerificationOtp.routeName);
                        } else if (state is SignUpError) {
                          context.showSnackbar(state.msg);
                          context.pop();
                        }
                      },

                      child: PrimartButton(
                        lableText: "Signin",
                        onpressed: () {
                          if (_formkey.currentState?.validate() == false) {
                            return;
                          }
                          final signUp = SignUpModel(
                            email: _email.text,
                            password: _password.text,
                            name: _name.text,
                          );
                          context.read<SignUpBloc>().add(SignUpEvent(signUp));
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text("Already have account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Login"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
