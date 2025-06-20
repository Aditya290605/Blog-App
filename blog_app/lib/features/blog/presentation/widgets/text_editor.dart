import 'package:flutter/material.dart';

class TextEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hintTex;
  const TextEditor({
    super.key,
    required this.controller,
    required this.hintTex,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintTex),
      maxLines: null,
    );
  }
}
