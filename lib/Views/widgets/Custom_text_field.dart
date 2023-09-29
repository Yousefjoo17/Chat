// ignore: file_names
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.hinttext, this.onchanged, this.obsecuretext});
  final String? hinttext;
  final Function(String)? onchanged;
  final bool? obsecuretext;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      validator: (data) {
        if (data!.isEmpty) {
          return 'requeird';
        }
        return null;
      },
      onChanged: onchanged,
      obscureText: obsecuretext ?? false,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(32),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }
}
