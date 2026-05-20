import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/extension/context_extesion.dart';
import 'package:lms/core/widgets/custom_text_form.dart';
import 'package:lms/core/widgets/primary_button.dart';
import 'package:lms/features/auth/bloc/login/login_bloc.dart';
import 'package:lms/features/auth/model/login_model.dart';
import 'package:lms/features/auth/pages/sign_up.dart';
import 'package:lms/features/home/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _isObscure = true;

  @override
  void dispose() {
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
                    child: BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginLoading) {
                          context.showLoadingDialog();
                        } else if (state is LoginLoaded) {
                          context.showSnackbar(state.msg);
                          context.pop();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Homepage()),
                            (_) => false,
                          );
                        } else if (state is LoginFailure) {
                          context.showSnackbar(state.msg);
                          context.pop();
                        }
                      },

                      child: PrimartButton(
                        lableText: "Login",
                        onpressed: () {
                          if (_formkey.currentState?.validate() == false) {
                            return;
                          }
                          final login = LoginModel(
                            email: _email.text,
                            password: _password.text,
                          );
                          context.read<LoginBloc>().add(
                            LoginEvent(loginModel: login),
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text("Dont  have account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UserLogin(),
                            ),
                          );
                        },
                        child: Text("signUp"),
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
