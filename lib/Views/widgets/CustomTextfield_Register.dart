import 'package:flutter/material.dart';

class CustomTextFieldRegister extends StatelessWidget {
  const CustomTextFieldRegister({
    super.key,
    required this.hinText,
    this.onChanged,
    required this.icon,
    this.maxLines,
    this.onSaved,
    this.hintTextColor,
  });
  final String hinText;
  final void Function(String)? onChanged;
  final Icon icon;
  final int? maxLines;
  final void Function(String?)? onSaved;
  final Color? hintTextColor;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'requeird';
        }
        return null;
      },
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        hintText: hinText,
        hintStyle: TextStyle(color: hintTextColor ?? Colors.black54),
        filled: true,
        fillColor: const Color.fromARGB(206, 250, 204, 250),
        prefixIcon: icon,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
