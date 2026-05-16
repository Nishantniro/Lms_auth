// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PrimartButton extends StatelessWidget {
  final void Function()? onpressed;
  final String lableText;

  const PrimartButton({super.key, this.onpressed, required this.lableText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        minimumSize: Size(double.infinity, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
      ),

      child: Text(
        lableText,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
      ),
    );
  }
}
