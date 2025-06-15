import 'package:blog_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextfeild extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;

  const CustomTextfeild({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
      obscureText: obscureText,
      controller: controller,

      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),

          borderSide: BorderSide(color: AppPallete.borderColor, width: 1.0),
        ),
      ),
    );
  }
}
