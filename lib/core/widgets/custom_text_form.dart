import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController? controller;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? Function(String?)? validator;

  const CustomTextForm({
    super.key,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),

      controller: controller,
    );
  }
}
